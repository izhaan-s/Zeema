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

    debugPrint('Notification service initialized');
  }

  /// Request permission to show notifications
  static Future<bool> requestPermission() async {
    final isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
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

      debugPrint('Scheduled notification: $title for ${utcTime.toString()}');
    } catch (e) {
      debugPrint('Error scheduling notification: $e');
    }
  }

  /// Get all scheduled and active notifications
  static Future<List<NotificationModel>> getActiveNotifications() async {
    try {
      final List<NotificationModel> activeNotifications =
          await AwesomeNotifications().listScheduledNotifications();
      return activeNotifications;
    } catch (e) {
      debugPrint('Error getting active notifications: $e');
      return [];
    }
  }

  /// Cancel a specific notification by ID
  static Future<void> cancel(int id) async {
    try {
      await AwesomeNotifications().cancel(id);
      debugPrint('Cancelled notification #$id');
    } catch (e) {
      debugPrint('Error cancelling notification #$id: $e');
    }
  }

  /// Cancel all notifications
  static Future<void> cancelAll() async {
    try {
      await AwesomeNotifications().cancelAll();
      debugPrint('Cancelled all notifications');
    } catch (e) {
      debugPrint('Error cancelling all notifications: $e');
    }
  }

  /// Debug function to print all active notifications
  static Future<void> printActiveNotifications() async {
    try {
      final notifications = await getActiveNotifications();
      debugPrint('Active notifications: ${notifications.length}');
      for (var notification in notifications) {
        debugPrint('ID: ${notification.content?.id}, '
            'Title: ${notification.content?.title}, '
            'Scheduled: ${notification.schedule?.toMap()}');
      }
    } catch (e) {
      debugPrint('Error printing active notifications: $e');
    }
  }
}
