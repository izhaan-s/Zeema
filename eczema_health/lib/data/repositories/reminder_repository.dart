import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/reminder_model.dart';
import 'package:flutter/material.dart';

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

      final dateTime = DateTime(
        now.year,
        now.month,
        now.day,
        time.hour,
        time.minute,
      );

      final reminder = ReminderModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: userId,
        title: title,
        description: description,
        reminderType: reminderType,
        dateTime: dateTime,
        repeatDays: repeatDays,
        isActive: true,
        createdAt: now,
        updatedAt: now,
      );

      final reminderMap = reminder.toMap();

      // Add field for dosage later on cba rn

      final data = await _supabase
        .from('reminders')
        .insert(reminderMap)
        .select()
        .single();
      
      return ReminderModel.fromMap(data);

    } catch (e) {
      rethrow;
    }
  }
}