import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/reminder_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ReminderRepository {
  final SupabaseClient _supabase;

  ReminderRepository({SupabaseClient? supabase})
      : _supabase = supabase ?? Supabase.instance.client;

  Future<ReminderModel> createReminder({
    required String title,
    String? description,
    required TimeOfDay time,
    required List<bool> repeatDays,
    String? dosage,
    String reminderType = 'medication',
  }) async {
    try {
      final userId = _supabase.auth.currentUser?.id ?? 'anonymous';
      final now = DateTime.now();

      final uuid = Uuid();
      final id = uuid.v4();

      final dateTime = DateTime.now().toUtc().copyWith(
            hour: time.hour,
            minute: time.minute,
            second: 0,
            millisecond: 0,
            microsecond: 0,
          );

      final formattedTime =
          '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:00';

      final reminder = ReminderModel(
        id: id,
        userId: userId,
        title: title,
        description: description,
        reminderType: reminderType,
        dateTime: dateTime,
        repeatDays: repeatDays,
        isActive: true,
        createdAt: now.toUtc(),
        updatedAt: now,
      );

      final reminderMap = reminder.toMap();

      reminderMap['time'] = formattedTime;

      // Add field for dosage later on cba rn

      final data = await _supabase
          .from('reminders')
          .insert(reminderMap)
          .select()
          .single();

      return ReminderModel.fromMap(data);
    } catch (e) {
      print("Error in ReminderRepository.createReminder: $e");
      if (e is FormatException) {
        print("Format exception details: ${e.source}");
      }
      rethrow;
    }
  }

  Future<List<ReminderModel>> getReminders() async {
    try {
      final userId = _supabase.auth.currentUser?.id ?? 'anonymous';

      final data = await _supabase
          .from('reminders')
          .select()
          .eq('user_id', userId)
          .order('time');

      print("Reminders retrieved: ${data.length}");
      print(data);

      return (data as List)
          .map((item) {
            try {
              return ReminderModel.fromMap(item);
            } catch (e) {
              print("Error parsing reminder: $e");
              return null;
            }
          })
          .whereType<ReminderModel>()
          .toList();
    } catch (e) {
      print("Error in ReminderRepository.getReminders: $e");
      rethrow;
    }
  }

  Future<List<ReminderModel>> getTodayReminders() async {
    try {
      final reminders = await getReminders();
      final today = DateTime.now().weekday - 1;

      return reminders.where((reminder) {
        // Check if the reminder is active and scheduled for today
        return reminder.isActive &&
            reminder.repeatDays.length > today &&
            (reminder.repeatDays[today] == true ||
                reminder.repeatDays[today] == 1);
      }).toList();
    } catch (e) {
      print("Error in ReminderRepository.getTodayReminders: $e");
      rethrow;
    }
  }
}
