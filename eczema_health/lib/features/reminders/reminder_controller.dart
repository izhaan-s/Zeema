import 'dart:convert';
import 'package:flutter/material.dart';
import '../../data/models/reminder_model.dart';
import '../../data/repositories/local/reminder_repository.dart';
import 'reminder_notification_manager.dart';
import 'notification_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ReminderController extends ChangeNotifier {
  final ReminderRepository _repository;
  List<ReminderModel> _reminders = [];
  bool _isLoading = false;
  bool _disposed = false; // Add disposal tracking

  ReminderController({required ReminderRepository repository})
      : _repository = repository {
    loadReminders();
  }

  List<ReminderModel> get reminders => _reminders;
  bool get isLoading => _isLoading;

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

  Future<void> loadReminders() async {
    if (_disposed) return; // Prevent operations after disposal

    _isLoading = true;
    notifyListeners();

    try {
      // Check notification permissions first
      bool hasPermission = await NotificationService.checkPermissions();
      if (!hasPermission) {
        hasPermission = await NotificationService.requestPermission();
      }

      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) {
        _reminders = [];
        if (!_disposed) {
          _isLoading = false;
          notifyListeners();
        }
        return;
      }
      final localReminders = await _repository.getReminders(userId);
      _reminders = localReminders
          .map((r) => ReminderModel(
                id: r.id,
                userId: r.userId,
                title: r.title,
                description: r.description,
                reminderType: r.reminderType,
                dateTime: r.time,
                repeatDays: _parseRepeatDays(r.repeatDays),
                isActive: r.isActive,
                createdAt: r.createdAt,
                updatedAt: r.updatedAt,
              ))
          .toList();

      // Schedule notifications for all loaded reminders
      if (hasPermission && !_disposed) {
        await ReminderNotificationManager.scheduleAllReminders(_reminders);
        // Check active notifications
        await NotificationService.printActiveNotifications();
      }
    } catch (e) {
      // Error loading reminders
      print('Error loading reminders: $e');
    } finally {
      if (!_disposed) {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<ReminderModel?> createReminder({
    required String title,
    String? description,
    required TimeOfDay time,
    required List<bool> repeatDays,
    String? dosage,
  }) async {
    try {
      final now = DateTime.now();
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User not logged in');
      }
      final model = ReminderModel(
        id: now.millisecondsSinceEpoch.toString(),
        userId: userId,
        title: title,
        description: description,
        reminderType: null,
        dateTime:
            DateTime(now.year, now.month, now.day, time.hour, time.minute),
        repeatDays: repeatDays.map((b) => b.toString()).toList(),
        isActive: true,
        createdAt: now,
        updatedAt: now,
      );
      await _repository.createReminder(model);
      await loadReminders(); // Refresh list
      return model;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateReminder({
    required String id,
    required String title,
    String? description,
    required TimeOfDay time,
    required List<bool> repeatDays,
  }) async {
    try {
      print(
          'ReminderController.updateReminder called with id: $id, title: $title');
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User not logged in');
      }

      // Find the existing reminder
      final existingReminderIndex = _reminders.indexWhere((r) => r.id == id);
      print('Found existing reminder at index: $existingReminderIndex');
      if (existingReminderIndex == -1) {
        throw Exception('Reminder not found');
      }

      final existingReminder = _reminders[existingReminderIndex];
      final now = DateTime.now();

      // Create updated reminder model
      final updatedReminder = ReminderModel(
        id: id,
        userId: userId,
        title: title,
        description: description,
        reminderType: existingReminder.reminderType,
        dateTime:
            DateTime(now.year, now.month, now.day, time.hour, time.minute),
        repeatDays: repeatDays.map((b) => b.toString()).toList(),
        isActive: existingReminder.isActive,
        createdAt: existingReminder.createdAt,
        updatedAt: now,
      );

      // Cancel old notification first (before any database changes)
      print('Canceling old notification...');
      await ReminderNotificationManager.cancelReminderNotification(
          existingReminder);

      print('Calling repository.updateReminder...');
      await _repository.updateReminder(updatedReminder);
      print('Repository update successful, reloading reminders...');

      // Reload from database to ensure consistency
      await loadReminders();

      // Note: loadReminders() already schedules all notifications, so we don't need to manually schedule here
      // Check remaining notifications
      await NotificationService.printActiveNotifications();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteReminder(String id) async {
    try {
      // Find reminder before deleting to cancel its notification
      final reminderToDelete =
          _reminders.firstWhere((reminder) => reminder.id == id);

      await _repository.deleteReminder(reminderToDelete);

      // Remove from local list and refresh UI
      _reminders.removeWhere((reminder) => reminder.id == id);
      notifyListeners();

      // Cancel notification for deleted reminder
      await ReminderNotificationManager.cancelReminderNotification(
          reminderToDelete);

      // Check remaining notifications
      await NotificationService.printActiveNotifications();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> toggleReminderStatus(String id, bool isActive) async {
    try {
      // await _repository.updateReminderStatus(id, isActive);
      final index = _reminders.indexWhere((reminder) => reminder.id == id);
      if (index != -1) {
        final updatedReminder = _reminders[index].copyWith(isActive: isActive);
        _reminders[index] = updatedReminder;
        notifyListeners();

        // Update notification based on new status
        bool hasPermission = await NotificationService.checkPermissions();
        if (hasPermission) {
          if (isActive) {
            await ReminderNotificationManager.scheduleReminderNotification(
                updatedReminder);
          } else {
            await ReminderNotificationManager.cancelReminderNotification(
                updatedReminder);
          }
          // Check active notifications after toggle
          await NotificationService.printActiveNotifications();
        } else if (isActive) {
          // If trying to activate, request permission
          await NotificationService.requestPermission();
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    _disposed = true;
    print('ReminderController disposed');
    super.dispose();
  }
}
