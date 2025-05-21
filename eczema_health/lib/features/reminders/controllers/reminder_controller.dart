import 'package:flutter/material.dart';
import '../../../data/models/reminder_model.dart';
import '../../../data/repositories/local_storage/reminder_repository.dart';
import '../../../data/local/app_database.dart';
import '../services/reminder_notification_manager.dart';
import '../services/notification_service.dart';

class ReminderController extends ChangeNotifier {
  late final ReminderRepository _repository;
  List<ReminderModel> _reminders = [];
  bool _isLoading = false;
  bool _isInitialized = false;

  ReminderController() {
    _initLocalRepository();
  }

  List<ReminderModel> get reminders => _reminders;
  bool get isLoading => _isLoading;

  Future<void> _initLocalRepository() async {
    final db = await DBProvider.instance.database;
    _repository = ReminderRepository(db);
    _isInitialized = true;
    await loadReminders();
  }

  Future<void> loadReminders() async {
    if (!_isInitialized) return;
    _isLoading = true;
    notifyListeners();

    try {
      // Check notification permissions first
      bool hasPermission = await NotificationService.checkPermissions();
      if (!hasPermission) {
        hasPermission = await NotificationService.requestPermission();
      }

      final userId = '1'; // TODO: Replace with actual user ID
      final localReminders = await _repository.getReminders(userId);
      _reminders = localReminders
          .map((r) => ReminderModel(
                id: r.id,
                userId: r.userId,
                title: r.title,
                description: r.description,
                reminderType: r.reminderType,
                dateTime: r.time,
                repeatDays: r.repeatDays.split(','),
                isActive: r.isActive,
                createdAt: r.createdAt,
                updatedAt: r.updatedAt,
              ))
          .toList();

      // Schedule notifications for all loaded reminders
      if (hasPermission) {
        await ReminderNotificationManager.scheduleAllReminders(_reminders);
        // Check active notifications
        await NotificationService.printActiveNotifications();
      }
    } catch (e) {
      // Error loading reminders
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _ensureInitialized() async {
    while (!_isInitialized) {
      await Future.delayed(const Duration(milliseconds: 10));
    }
  }

  Future<ReminderModel?> createReminder({
    required String title,
    String? description,
    required TimeOfDay time,
    required List<bool> repeatDays,
    String? dosage,
  }) async {
    await _ensureInitialized();
    try {
      final now = DateTime.now();
      final model = ReminderModel(
        id: now.millisecondsSinceEpoch.toString(),
        userId: '1', // Replace with actual user ID
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

  Future<void> deleteReminder(String id) async {
    await _ensureInitialized();
    try {
      // Find reminder before deleting to cancel its notification
      final reminderToDelete =
          _reminders.firstWhere((reminder) => reminder.id == id);

      // await _repository.deleteReminder(id);
      // _reminders.removeWhere((reminder) => reminder.id == id);
      // notifyListeners();

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
    await _ensureInitialized();
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
}
