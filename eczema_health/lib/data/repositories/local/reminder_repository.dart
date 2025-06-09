import 'package:eczema_health/data/models/reminder_model.dart';
import 'package:drift/drift.dart';
import '../../app_database.dart';
import 'dart:convert';

class ReminderRepository {
  final AppDatabase _db;

  ReminderRepository(this._db);

  Future<void> saveReminder(Reminder reminder) async {
    await _db.into(_db.reminders).insert(
          RemindersCompanion.insert(
            id: reminder.id,
            title: reminder.title,
            description: Value(reminder.description),
            repeatDays: reminder.repeatDays,
            createdAt: reminder.createdAt,
            updatedAt: reminder.updatedAt,
            userId: reminder.userId,
            time: reminder.time,
          ),
        );
  }

  Future<void> createReminder(ReminderModel model) async {
    await _db.into(_db.reminders).insert(
          RemindersCompanion.insert(
            id: model.id,
            userId: model.userId,
            title: model.title,
            description: Value(model.description),
            reminderType: Value(model.reminderType),
            time: model.dateTime,
            repeatDays: model.repeatDays.join(','),
            isActive: Value(model.isActive),
            createdAt: model.createdAt,
            updatedAt: model.updatedAt,
          ),
        );
  }

  Future<List<Reminder>> getReminders(String userId) async {
    return (_db.select(_db.reminders)
          ..where((tbl) => tbl.userId.equals(userId)))
        .get();
  }

  Future<void> deleteReminder(ReminderModel reminder) async {
    await (_db.delete(_db.reminders)
          ..where((tbl) => tbl.id.equals(reminder.id)))
        .go();
    await _db.into(_db.syncState).insertOnConflictUpdate(
          SyncStateCompanion.insert(
            userId: reminder.userId,
            targetTable: 'reminders',
            operation: 'delete',
            lastUpdatedAt: reminder.updatedAt,
            lastSynced: Value(reminder.updatedAt),
            retryCount: const Value(0),
            error: const Value(null),
            rowId: reminder.id,
            isSynced: const Value(false),
          ),
        );
  }
}
