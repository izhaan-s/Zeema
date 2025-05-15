import 'package:flutter/material.dart';
import '../../../data/models/reminder_model.dart';
import '../../../data/repositories/cloud/reminder_repository.dart';
import '../services/reminder_notification_manager.dart';
import '../services/notification_service.dart';

class ReminderController extends ChangeNotifier {
  final ReminderRepository _repository;
  List<ReminderModel> _reminders = [];
  bool _isLoading = false;

  ReminderController({ReminderRepository? repository})
      : _repository = repository ?? ReminderRepository();

  List<ReminderModel> get reminders => _reminders;
  bool get isLoading => _isLoading;

  Future<void> loadReminders() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Check notification permissions first
      bool hasPermission = await NotificationService.checkPermissions();
      if (!hasPermission) {
        debugPrint('Notifications permission not granted, requesting...');
        hasPermission = await NotificationService.requestPermission();
        debugPrint('Notification permission granted: $hasPermission');
      }

      _reminders = await _repository.getReminders();
      debugPrint('Loaded ${_reminders.length} reminders from repository');

      // Schedule notifications for all loaded reminders
      if (hasPermission) {
        await ReminderNotificationManager.scheduleAllReminders(_reminders);
        // Print active notifications for debugging
        await NotificationService.printActiveNotifications();
      } else {
        debugPrint(
            'Skipping notification scheduling due to lack of permissions');
      }
    } catch (e) {
      debugPrint('Error loading reminders: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
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
      final reminder = await _repository.createReminder(
        title: title,
        description: description,
        time: time,
        repeatDays: repeatDays,
        dosage: dosage,
      );

      _reminders.add(reminder);
      notifyListeners();

      // Check permissions before scheduling
      bool hasPermission = await NotificationService.checkPermissions();
      if (hasPermission) {
        // Schedule notification for the new reminder
        await ReminderNotificationManager.scheduleReminderNotification(
            reminder);
        await NotificationService.printActiveNotifications();
      } else {
        debugPrint('Cannot schedule notification - permission denied');
        bool requested = await NotificationService.requestPermission();
        if (requested) {
          await ReminderNotificationManager.scheduleReminderNotification(
              reminder);
        }
      }

      return reminder;
    } catch (e) {
      debugPrint('Error creating reminder: $e');
      rethrow;
    }
  }

  Future<void> deleteReminder(String id) async {
    try {
      // Find reminder before deleting to cancel its notification
      final reminderToDelete =
          _reminders.firstWhere((reminder) => reminder.id == id);

      await _repository.deleteReminder(id);
      _reminders.removeWhere((reminder) => reminder.id == id);
      notifyListeners();

      // Cancel notification for deleted reminder
      await ReminderNotificationManager.cancelReminderNotification(
          reminderToDelete);

      // Debug: print remaining notifications
      await NotificationService.printActiveNotifications();
    } catch (e) {
      debugPrint('Error deleting reminder: $e');
      rethrow;
    }
  }

  Future<void> toggleReminderStatus(String id, bool isActive) async {
    try {
      await _repository.updateReminderStatus(id, isActive);
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
          // Debug: print active notifications after toggle
          await NotificationService.printActiveNotifications();
        } else if (isActive) {
          // If trying to activate, request permission
          debugPrint('Requesting notification permission for toggled reminder');
          await NotificationService.requestPermission();
        }
      }
    } catch (e) {
      debugPrint('Error toggling reminder status: $e');
      rethrow;
    }
  }
}
