import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static const String channelKey = 'reminder_channel';
  static const String channelName = 'Reminders';
  static const String channelDescription = 'Channel for reminder notifications';

  static Future<void> init() async {
    // Make sure old notifications are cleared on startup to avoid issues
    await AwesomeNotifications().cancelAll();

    // Initialize the notification system
    await AwesomeNotifications().initialize(
      null, // Setting to null since the specified icon is causing issues
      [
        NotificationChannel(
          channelGroupKey: 'reminder_group',
          channelKey: channelKey,
          channelName: channelName,
          channelDescription: channelDescription,
          defaultColor: Colors.blue,
          importance: NotificationImportance.High,
          ledColor: Colors.blue,
          channelShowBadge: true,
          // Enable vibration and sound
          enableVibration: true,
          playSound: true,
        )
      ],
      // No channel groups for simplified setup
      debug: true,
    );

    // Request notification permissions
    await requestPermission();
  }

  /// Request permission to show notifications
  static Future<bool> requestPermission({BuildContext? context}) async {
    final isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed && context != null) {
      final result = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Allow Notifications?'),
          content: const Text(
              'We need notification access to remind you to take your medication.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Deny'),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Allow'),
            ),
          ],
        ),
      );
      if (result == true) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
        return await AwesomeNotifications().isNotificationAllowed();
      } else {
        return false;
      }
    } else if (!isAllowed) {
      // If no context, fallback to direct request (legacy)
      await AwesomeNotifications().requestPermissionToSendNotifications();
      return await AwesomeNotifications().isNotificationAllowed();
    }
    return isAllowed;
  }

  /// Check if notification permissions are granted
  static Future<bool> checkPermissions() async {
    return await AwesomeNotifications().isNotificationAllowed();
  }

  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime utcTime,
  }) async {
    if (utcTime.isBefore(DateTime.now().toUtc())) return;

    try {
      // We'll use a simpler notification with fewer options to avoid issues
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: id,
          channelKey: channelKey,
          title: title,
          body: body,
          notificationLayout: NotificationLayout.Default,
        ),
        schedule: NotificationCalendar.fromDate(
          date: utcTime,
          allowWhileIdle: true,
        ),
      );
    } catch (e) {
      // Error scheduling notification
    }
  }

  /// Get all scheduled and active notifications
  static Future<List<NotificationModel>> getActiveNotifications() async {
    try {
      final List<NotificationModel> activeNotifications =
          await AwesomeNotifications().listScheduledNotifications();
      return activeNotifications;
    } catch (e) {
      // Error getting active notifications
      return [];
    }
  }

  /// Cancel a specific notification by ID
  static Future<void> cancel(int id) async {
    try {
      await AwesomeNotifications().cancel(id);
    } catch (e) {
      // Error cancelling notification
    }
  }

  /// Cancel all notifications
  static Future<void> cancelAll() async {
    try {
      await AwesomeNotifications().cancelAll();
    } catch (e) {
      // Error cancelling all notifications
    }
  }

  /// Debug function to print all active notifications
  static Future<void> printActiveNotifications() async {
    try {
      await getActiveNotifications();
      // Notifications information no longer needed
    } catch (e) {
      // Error with active notifications
    }
  }
}
