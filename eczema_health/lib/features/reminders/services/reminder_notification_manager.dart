import '../../../data/models/reminder_model.dart';
import 'notification_service.dart';
import '../../../data/repositories/local/reminder_repository.dart';

class ReminderNotificationManager {
  final ReminderRepository _repository;

  ReminderNotificationManager(this._repository);

  // Schedule a notification for a single reminder
  static Future<void> scheduleReminderNotification(
      ReminderModel reminder) async {
    if (!reminder.isActive) {
      await cancelReminderNotification(reminder);
      return;
    }

    try {
      final DateTime notificationTime = _getNextOccurrence(reminder);

      // Generate a stable, unique ID for this reminder
      final int notificationId = reminder.id.hashCode;

      // Generate a descriptive body if none was provided
      final String body = reminder.description ??
          'Time for your ${reminder.reminderType?.toLowerCase() ?? 'reminder'}';

      // Check notification permission before scheduling
      final bool hasPermission = await NotificationService.checkPermissions();
      if (!hasPermission) {
        return;
      }

      await NotificationService.scheduleNotification(
        id: notificationId,
        title: reminder.title,
        body: body,
        utcTime: notificationTime.toUtc(),
      );
    } catch (e) {
      // Error scheduling notification
    }
  }

  // Cancel a notification for a reminder
  static Future<void> cancelReminderNotification(ReminderModel reminder) async {
    try {
      final int notificationId = reminder.id.hashCode;
      await NotificationService.cancel(notificationId);
    } catch (e) {
      // Error cancelling notification
    }
  }

  // Schedule notifications for all reminders
  static Future<void> scheduleAllReminders(
      List<ReminderModel> reminders) async {
    try {
      // First cancel all existing notifications to avoid duplicates
      await NotificationService.cancelAll();

      // Check notification permission
      final bool hasPermission = await NotificationService.checkPermissions();
      if (!hasPermission) {
        final granted = await NotificationService.requestPermission();
        if (!granted) {
          return;
        }
      }

      for (final reminder in reminders) {
        if (reminder.isActive) {
          await scheduleReminderNotification(reminder);
        }
      }
    } catch (e) {
      // Error scheduling all reminders
    }
  }

  // Calculate the next occurrence of a reminder based on repeat pattern
  static DateTime _getNextOccurrence(ReminderModel reminder) {
    try {
      final now = DateTime.now();
      final reminderTime = reminder.dateTime;

      // Create a DateTime with today's date but the reminder's time
      final timeToday = DateTime(
        now.year,
        now.month,
        now.day,
        reminderTime.hour,
        reminderTime.minute,
      );

      // If it's a daily reminder and today's time hasn't passed yet, use today
      final List<bool> activeDays = reminder.repeatDays
          .map((day) => day == 'true' || (day is bool && day == true))
          .toList();

      // Check if all days are active (daily reminder)
      final bool isDaily = activeDays.every((day) => day);
      if (isDaily && timeToday.isAfter(now)) {
        return timeToday;
      }

      // If it's a weekly/custom reminder or today's time has passed, find next active day
      // Start checking from today
      for (int daysToAdd = 0; daysToAdd < 8; daysToAdd++) {
        final checkDate = now.add(Duration(days: daysToAdd));
        final dayIndex = checkDate.weekday - 1; // 0 = Monday, 6 = Sunday

        // Adjust for Sunday being 6 in our array but 7 in DateTime.weekday
        final adjustedIndex = dayIndex == 7 ? 6 : dayIndex;

        // If this day is active and it's not today or today's time hasn't passed
        if ((daysToAdd > 0 || timeToday.isAfter(now)) &&
            adjustedIndex < activeDays.length &&
            activeDays[adjustedIndex]) {
          return DateTime(
            checkDate.year,
            checkDate.month,
            checkDate.day,
            reminderTime.hour,
            reminderTime.minute,
          );
        }
      }

      // If no day found or all days passed for this week, use next week's first active day
      for (int i = 0; i < activeDays.length; i++) {
        if (activeDays[i]) {
          // i+1 is the weekday (1=Monday, 7=Sunday)
          final dayOfWeek = i + 1;

          // Calculate days until next occurrence of this weekday
          int daysUntil = dayOfWeek - now.weekday;
          if (daysUntil <= 0) daysUntil += 7; // Go to next week

          return DateTime(
            now.year,
            now.month,
            now.day + daysUntil,
            reminderTime.hour,
            reminderTime.minute,
          );
        }
      }

      // Fallback (should never happen if reminder has at least one active day)
      return reminderTime.isAfter(now)
          ? reminderTime
          : reminderTime.add(const Duration(days: 1));
    } catch (e) {
      // Return a safe fallback - 1 day from now
      return DateTime.now().add(const Duration(days: 1));
    }
  }
}
