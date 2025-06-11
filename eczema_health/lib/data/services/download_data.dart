import 'package:eczema_health/data/app_database.dart';
import 'package:drift/drift.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:convert';

class DownloadData {
  final String userId;
  final SupabaseClient _supabase = Supabase.instance.client;
  final AppDatabase _db;

  DownloadData(this.userId, this._db);

  String _handleArrayField(dynamic value) {
    if (value == null) return '';
    if (value is List) {
      return value.join(','); // Convert array to comma-separated string
    }
    if (value is String) {
      // If it's already a string, check if it's JSON array
      if (value.startsWith('[') && value.endsWith(']')) {
        try {
          final decoded = jsonDecode(value);
          if (decoded is List) {
            return decoded.join(',');
          }
        } catch (e) {
          // If JSON decode fails, return the string as-is
        }
      }
      return value;
    }
    return value.toString();
  }

  Future<void> _downloadSymptomEntries() async {
    try {
      final data =
          await _supabase.from('symptoms').select('*').eq('user_id', userId);

      print('📥 Downloading ${data.length} symptom entries...');

      for (final item in data) {
        await _db.into(_db.symptomEntries).insertOnConflictUpdate(
              SymptomEntriesCompanion.insert(
                id: item['id'],
                userId: item['user_id'],
                date: DateTime.parse(item['date']),
                isFlareup: item['is_flareup'],
                severity: item['severity'].toString(), // Convert to string
                affectedAreas: _handleArrayField(item['affected_areas']),
                symptoms: Value(_handleArrayField(item['symptoms'])),
                notes: Value(_handleArrayField(item['notes'])),
                createdAt: DateTime.parse(item['created_at']),
                updatedAt: DateTime.parse(item['updated_at']),
              ),
            );
      }
      print('✅ Downloaded ${data.length} symptom entries');
    } catch (e) {
      print('❌ Error downloading symptom entries: $e');
    }
  }
  // Gonna have to do photos later there is no syncing for that :skull:

  Future<void> _downloadReminder(String userId) async {
    try {
      final data =
          await _supabase.from('reminders').select('*').eq('user_id', userId);

      for (final item in data) {
        await _db.into(_db.reminders).insertOnConflictUpdate(
              RemindersCompanion.insert(
                id: item['id'],
                userId: item['user_id'],
                title: item['title'],
                description: Value(item['description']),
                reminderType: Value(item['reminder_type']),
                time: _parseTimeField(item['time']),
                repeatDays: _handleArrayField(item['repeat_days']),
                isActive: Value(item['is_active'] ?? true),
                createdAt: DateTime.parse(item['created_at']),
                updatedAt: DateTime.parse(item['updated_at']),
              ),
            );
        print('Downloaded reminder: ${item['title']}');
      }
    } catch (e) {
      print('Error downloading reminders: $e');
    }
  }

  Future<void> _downloadMedications(String userId) async {
    try {
      final data =
          await _supabase.from('medications').select('*').eq('user_id', userId);

      for (final item in data) {
        await _db.into(_db.medications).insertOnConflictUpdate(
              MedicationsCompanion.insert(
                id: item['id'],
                userId: item['user_id'],
                name: item['name'],
                dosage: item['dosage'],
                frequency: item['frequency'],
                startDate: DateTime.parse(item['start_date']),
                endDate: item['end_date'] != null
                    ? Value(DateTime.parse(item['end_date']))
                    : const Value.absent(),
                effectiveness: Value(item['effectiveness']),
                sideEffects: Value(item['side_effects']),
                notes: Value(item['notes']),
                isPreloaded: Value(item['is_preloaded'] ?? false),
                isSteroid: Value(item['is_steroid'] ?? false),
                createdAt: DateTime.parse(item['created_at']),
                updatedAt: DateTime.parse(item['updated_at']),
              ),
            );
        print('Downloaded medication: ${item['name']}');
      }
    } catch (e) {
      print('Error downloading medications: $e');
    }
  }

  DateTime _parseTimeField(String timeStr) {
    final now = DateTime.now();
    final timeParts = timeStr.split(':');
    return DateTime(
      now.year, now.month, now.day,
      int.parse(timeParts[0]), // hour
      int.parse(timeParts[1]), // minute
      int.parse(timeParts[2]), // second
    );
  }

  /// Download all user data
  Future<void> downloadAllUserData() async {
    print('📥 Downloading user data...');
    try {
      await _downloadSymptomEntries();
      await _downloadReminder(userId);
      await _downloadMedications(userId);
      // TODO: Add photos and lifestyle when ready
      print('✅ Download completed');
    } catch (e) {
      print('❌ Download failed: $e');
      rethrow;
    }
  }
}
