import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/reminder_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart'; 


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

      final formattedTime = '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:00';

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
}