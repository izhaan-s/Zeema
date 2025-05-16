// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

// Temporarily disabled notification model
class NotificationModel {
  final dynamic content;
  final dynamic schedule;
  
  NotificationModel({this.content, this.schedule});
}

/// Temporary stub implementation for NotificationService
/// This is a placeholder while the awesome_notifications package is disabled
class NotificationService {
  static const String channelKey = 'reminder_channel';
  static const String channelName = 'Reminders';
  static const String channelDescription = 'Channel for reminder notifications';

  /// Stub implementation - no actual initialization
  static Future<void> init() async {
    debugPrint('[STUB] Notification service initialization skipped');
  }

  /// Stub implementation - always returns true
  static Future<bool> requestPermission() async {
    debugPrint('[STUB] Notification permission request skipped');
    return true;
  }

  /// Stub implementation - always returns true
  static Future<bool> checkPermissions() async {
    debugPrint('[STUB] Notification permission check skipped');
    return true;
  }

  /// Stub implementation - logs the notification details but doesn't schedule anything
  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime utcTime,
  }) async {
    if (utcTime.isBefore(DateTime.now().toUtc())) return;

    // Log the notification details
    debugPrint('[STUB] Would schedule notification: $title for ${utcTime.toString()}');
  }

  /// Stub implementation - returns an empty list
  static Future<List<NotificationModel>> getActiveNotifications() async {
    debugPrint('[STUB] Get active notifications - returns empty list');
    return [];
  }

  /// Stub implementation - logs the cancellation
  static Future<void> cancel(int id) async {
    debugPrint('[STUB] Would cancel notification #$id');
  }

  /// Stub implementation - logs the cancellation
  static Future<void> cancelAll() async {
    debugPrint('[STUB] Would cancel all notifications');
  }

  /// Stub implementation - logs that there are no active notifications
  static Future<void> printActiveNotifications() async {
    debugPrint('[STUB] No active notifications (notifications disabled)');
  }
}
