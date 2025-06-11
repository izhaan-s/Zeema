import 'dart:convert';
import 'package:eczema_health/data/app_database.dart';
import 'package:eczema_health/data/repositories/local/symptom_repository.dart';
import 'package:eczema_health/data/repositories/local/photo_repository.dart';
import 'package:eczema_health/data/repositories/local/reminder_repository.dart';
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

  SyncService({
    required AppDatabase db,
    required LocalSymptomRepository localSymptomRepo,
    required PhotoRepository photoRepo,
    required ReminderRepository reminderRepo,
    required SymptomRepository cloudRepo,
  })  : _db = db,
        _localRepo = localSymptomRepo,
        _photoRepo = photoRepo,
        _reminderRepo = reminderRepo,
        _cloudRepo = cloudRepo,
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

  /// Parses repeat days from either old comma-separated format or new JSON format
  List<String> _parseRepeatDays(String repeatDaysStr) {
    try {
      // Try to parse as JSON first (new format)
      final List<dynamic> jsonList = jsonDecode(repeatDaysStr);
      return jsonList.map((e) => e.toString()).toList();
    } catch (e) {
      // If JSON parsing fails, treat as comma-separated string (old format)
      return repeatDaysStr.split(',');
    }
  }

  Future<void> syncData() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) {
      print('Migration skipped: User not logged in');
      return;
    }

    // Check if sync should proceed (every 24 hours or if change count threshold is met)
    final shouldProceed = await shouldSync();
    if (!shouldProceed) {
      print(
          'Sync skipped: Less than 24 hours since last sync and change count threshold not met.');
      return;
    }

    try {
      // MIGRATION: SYMPTOMS
      final localSymptoms = await _localRepo.getSymptomEntries(userId);
      print('Uploading [32m[1m${localSymptoms.length}[0m symptoms...');
      for (final entry in localSymptoms) {
        try {
          final response = await _supabase.from('symptoms').upsert({
            'id': entry.id,
            'user_id': entry.userId,
            'date': entry.date.toIso8601String(),
            'is_flareup': entry.isFlareup,
            'severity': entry.severity,
            'affected_areas': entry.affectedAreas,
            'symptoms': entry.symptoms,
            'notes': entry.notes,
            'created_at': entry.createdAt.toIso8601String(),
            'updated_at': entry.updatedAt.toIso8601String(),
          });
          print('Symptom ${entry.id} upload response: $response');
        } catch (e) {
          print('Failed to upload symptom ${entry.id}: $e');
        }
      }

      // MIGRATION: REMINDERS
      final localReminders = await _reminderRepo.getReminders(userId);
      print('Uploading [32m[1m${localReminders.length}[0m reminders...');
      for (final reminder in localReminders) {
        try {
          final response = await _supabase.from('reminders').upsert({
            'id': reminder.id,
            'user_id': reminder.userId,
            'title': reminder.title,
            'description': reminder.description,
            'reminder_type': reminder.reminderType,
            'time':
                reminder.time.toIso8601String().substring(11, 19), // HH:mm:ss
            'repeat_days': _parseRepeatDays(reminder.repeatDays),
            'is_active': reminder.isActive,
            'created_at': reminder.createdAt.toIso8601String(),
            'updated_at': reminder.updatedAt.toIso8601String(),
          });
          print('Reminder ${reminder.id} upload response: $response');
        } catch (e) {
          print('Failed to upload reminder ${reminder.id}: $e');
        }
      }

      // MIGRATION: PHOTOS
      final localPhotos = await _photoRepo.getPhotos(userId);
      print('Uploading [32m[1m${localPhotos.length}[0m photos...');
      for (final photo in localPhotos) {
        try {
          final response = await _supabase.from('photos').upsert({
            'id': photo['id'],
            'user_id': userId,
            'image_url': photo['image'],
            'body_part': photo['bodyPart'],
            'date': photo['date'],
          });
          print('Photo ${photo['id']} upload response: $response');
        } catch (e) {
          print('Failed to upload photo ${photo['id']}: $e');
        }
      }

      // Update last sync time and reset change counts after successful migration
      await updateLastSync();
      await resetChangeCounts();

      print('Migration complete!');
    } catch (e, st) {
      print('Migration failed: $e\n$st');
      rethrow;
    }
  }
}
