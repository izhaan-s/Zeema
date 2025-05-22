import 'package:eczema_health/data/local/app_database.dart';
import 'package:eczema_health/data/repositories/local_storage/symptom_repository.dart';
import 'package:eczema_health/data/repositories/local_storage/photo_repository.dart';
import 'package:eczema_health/data/repositories/local_storage/reminder_repository.dart';
import 'package:eczema_health/data/repositories/cloud/symptom_repository.dart';
import 'package:eczema_health/data/models/symptom_entry_model.dart';
import 'package:eczema_health/data/models/photo_entry_model.dart';
import 'package:eczema_health/data/models/reminder_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SyncService {
  final AppDatabase _db;
  final LocalSymptomRepository _localRepo;
  final PhotoRepository _photoRepo;
  final ReminderRepository _reminderRepo;
  final SymptomRepository _cloudRepo;
  final SupabaseClient _supabase;

  // Keys for different types of data
  static const String _lastSyncKey = 'last_sync_timestamp';
  static const String _symptomChangeCountKey = 'symptom_change_count';
  static const String _photoChangeCountKey = 'photo_change_count';
  static const String _reminderChangeCountKey = 'reminder_change_count';
  static const int _maxChanges = 20;
  static const Duration _syncInterval = Duration(hours: 24);

  SyncService(this._db)
      : _localRepo = LocalSymptomRepository(_db),
        _photoRepo = PhotoRepository(_db),
        _reminderRepo = ReminderRepository(_db),
        _cloudRepo = SymptomRepository(),
        _supabase = Supabase.instance.client;

  Future<bool> shouldSync() async {
    final prefs = await SharedPreferences.getInstance();
    final lastSync = prefs.getInt(_lastSyncKey);

    // Check if any type of data has reached max changes
    final symptomChanges = prefs.getInt(_symptomChangeCountKey) ?? 0;
    final photoChanges = prefs.getInt(_photoChangeCountKey) ?? 0;
    final reminderChanges = prefs.getInt(_reminderChangeCountKey) ?? 0;

    if (lastSync == null) return true;
    if (symptomChanges >= _maxChanges ||
        photoChanges >= _maxChanges ||
        reminderChanges >= _maxChanges) return true;

    final lastSyncTime = DateTime.fromMillisecondsSinceEpoch(lastSync);
    return DateTime.now().difference(lastSyncTime) >= _syncInterval;
  }

  Future<void> incrementChangeCount(String type) async {
    final prefs = await SharedPreferences.getInstance();
    String key;
    switch (type) {
      case 'symptom':
        key = _symptomChangeCountKey;
        break;
      case 'photo':
        key = _photoChangeCountKey;
        break;
      case 'reminder':
        key = _reminderChangeCountKey;
        break;
      default:
        throw Exception('Invalid change type: $type');
    }

    final currentCount = prefs.getInt(key) ?? 0;
    await prefs.setInt(key, currentCount + 1);
  }

  Future<void> resetChangeCounts() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_symptomChangeCountKey, 0);
    await prefs.setInt(_photoChangeCountKey, 0);
    await prefs.setInt(_reminderChangeCountKey, 0);
  }

  Future<void> updateLastSync() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lastSyncKey, DateTime.now().millisecondsSinceEpoch);
  }

  Future<void> syncData() async {
    if (!await shouldSync()) return;

    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) {
      print('Sync skipped: User not logged in');
      return;
    }

    try {
      // Sync symptoms
      await _syncSymptoms(userId);

      // Sync photos
      await _syncPhotos(userId);

      // Sync reminders
      await _syncReminders(userId);

      // Reset change counts and update last sync
      await resetChangeCounts();
      await updateLastSync();
    } catch (e) {
      print('Sync failed: $e');
      rethrow;
    }
  }

  Future<void> _syncSymptoms(String userId) async {
    // Get local changes
    final localEntries = await _localRepo.getSymptomEntries(userId);

    // Get remote changes
    final remoteEntries = await _cloudRepo.getSymptomEntries();

    // Handle conflicts and sync
    for (final localEntry in localEntries) {
      final remoteEntry = remoteEntries.firstWhere(
        (entry) => entry.id == localEntry.id,
        orElse: () => localEntry,
      );

      if (remoteEntry.updatedAt.isAfter(localEntry.updatedAt)) {
        // Remote is newer, update local
        await _localRepo.updateSymptomEntry(remoteEntry);
      } else if (localEntry.updatedAt.isAfter(remoteEntry.updatedAt)) {
        // Local is newer, update remote
        await _cloudRepo.addSymptomEntry(localEntry);
      }
    }

    // Add new remote entries to local
    for (final remoteEntry in remoteEntries) {
      if (!localEntries.any((entry) => entry.id == remoteEntry.id)) {
        await _localRepo.addSymptomEntry(remoteEntry);
      }
    }
  }

  Future<void> _syncPhotos(String userId) async {
    // Get local photos
    final localPhotos = await _photoRepo.getPhotos(userId);

    // Get remote photos
    final remoteResponse =
        await _supabase.from('photos').select().eq('user_id', userId);

    final remotePhotos = (remoteResponse as List)
        .map((photo) => PhotoEntryModel.fromMap(photo))
        .toList();

    // Handle conflicts and sync
    for (final localPhoto in localPhotos) {
      final remotePhoto = remotePhotos.firstWhere(
        (photo) => photo.id == localPhoto['id'],
        orElse: () => PhotoEntryModel(
          id: localPhoto['id']!,
          userId: userId,
          imageUrl: localPhoto['image']!,
          bodyPart: localPhoto['bodyPart']!,
          itchIntensity: 0,
          notes: null,
          date: DateTime.parse(localPhoto['date']!),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      // Compare timestamps and sync accordingly
      final localDate = DateTime.parse(localPhoto['date']!);
      final remoteDate = remotePhoto.date;

      if (remoteDate.isAfter(localDate)) {
        // Download remote photo
        await _photoRepo.savePhoto(
          userId,
          remotePhoto.bodyPart,
          remotePhoto.imageUrl,
          remoteDate,
          remotePhoto.notes,
        );
      } else if (localDate.isAfter(remoteDate)) {
        // Upload local photo
        await _supabase.from('photos').upsert({
          'id': localPhoto['id'],
          'user_id': userId,
          'image_url': localPhoto['image'],
          'body_part': localPhoto['bodyPart'],
          'date': localDate.toIso8601String(),
        });
      }
    }

    // Add new remote photos to local
    for (final remotePhoto in remotePhotos) {
      if (!localPhotos.any((photo) => photo['id'] == remotePhoto.id)) {
        await _photoRepo.savePhoto(
          userId,
          remotePhoto.bodyPart,
          remotePhoto.imageUrl,
          remotePhoto.date,
          remotePhoto.notes,
        );
      }
    }
  }

  Future<void> _syncReminders(String userId) async {
    // Get local reminders
    final localReminders = await _reminderRepo.getReminders(userId);

    // Get remote reminders
    final remoteResponse =
        await _supabase.from('reminders').select().eq('user_id', userId);

    final remoteReminders = (remoteResponse as List)
        .map((reminder) => ReminderModel.fromMap(reminder))
        .toList();

    // Handle conflicts and sync
    for (final localReminder in localReminders) {
      final remoteReminder = remoteReminders.firstWhere(
        (reminder) => reminder.id == localReminder.id,
        orElse: () => ReminderModel(
          id: localReminder.id,
          userId: userId,
          title: localReminder.title,
          description: localReminder.description,
          reminderType: localReminder.reminderType,
          dateTime: localReminder.time,
          repeatDays: localReminder.repeatDays.split(','),
          isActive: localReminder.isActive,
          createdAt: localReminder.createdAt,
          updatedAt: localReminder.updatedAt,
        ),
      );

      if (remoteReminder.updatedAt.isAfter(localReminder.updatedAt)) {
        // Update local reminder
        await _reminderRepo.saveReminder(Reminder(
          id: remoteReminder.id,
          userId: userId,
          title: remoteReminder.title,
          description: remoteReminder.description,
          reminderType: remoteReminder.reminderType,
          time: remoteReminder.dateTime,
          repeatDays: remoteReminder.repeatDays.join(','),
          isActive: remoteReminder.isActive,
          createdAt: remoteReminder.createdAt,
          updatedAt: remoteReminder.updatedAt,
        ));
      } else if (localReminder.updatedAt.isAfter(remoteReminder.updatedAt)) {
        // Update remote reminder
        await _supabase.from('reminders').upsert(ReminderModel(
              id: localReminder.id,
              userId: userId,
              title: localReminder.title,
              description: localReminder.description,
              reminderType: localReminder.reminderType,
              dateTime: localReminder.time,
              repeatDays: localReminder.repeatDays.split(','),
              isActive: localReminder.isActive,
              createdAt: localReminder.createdAt,
              updatedAt: localReminder.updatedAt,
            ).toMap());
      }
    }

    // Add new remote reminders to local
    for (final remoteReminder in remoteReminders) {
      if (!localReminders.any((reminder) => reminder.id == remoteReminder.id)) {
        await _reminderRepo.saveReminder(Reminder(
          id: remoteReminder.id,
          userId: userId,
          title: remoteReminder.title,
          description: remoteReminder.description,
          reminderType: remoteReminder.reminderType,
          time: remoteReminder.dateTime,
          repeatDays: remoteReminder.repeatDays.join(','),
          isActive: remoteReminder.isActive,
          createdAt: remoteReminder.createdAt,
          updatedAt: remoteReminder.updatedAt,
        ));
      }
    }
  }
}
