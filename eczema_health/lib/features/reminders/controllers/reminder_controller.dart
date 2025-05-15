import 'package:flutter/material.dart';
import '../../../data/models/reminder_model.dart';
import '../../../data/repositories/cloud/reminder_repository.dart';

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
      _reminders = await _repository.getReminders();
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
      final now = DateTime.now();
      final dateTime = DateTime(
        now.year,
        now.month,
        now.day,
        time.hour,
        time.minute,
      );

      final reminder = await _repository.createReminder(
        title: title,
        description: description,
        time: time,
        repeatDays: repeatDays,
        dosage: dosage,
      );

      _reminders.add(reminder);
      notifyListeners();
      return reminder;
    } catch (e) {
      debugPrint('Error creating reminder: $e');
      rethrow;
    }
  }

  Future<void> deleteReminder(String id) async {
    try {
      await _repository.deleteReminder(id);
      _reminders.removeWhere((reminder) => reminder.id == id);
      notifyListeners();
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
        _reminders[index] = _reminders[index].copyWith(isActive: isActive);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error toggling reminder status: $e');
      rethrow;
    }
  }
}
