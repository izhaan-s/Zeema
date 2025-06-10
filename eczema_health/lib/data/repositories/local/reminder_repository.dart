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
    await _db.into(_db.syncState).insert(
          SyncStateCompanion.insert(
            userId: model.userId,
            targetTable: 'reminders',
            operation: 'insert',
            lastUpdatedAt: model.updatedAt,
            lastSynced: Value(null),
            retryCount: const Value(0),
            error: const Value(null),
            rowId: model.id,
            isSynced: const Value(false),
          ),
        );
  }

  Future<List<Reminder>> getReminders(String userId) async {
    return (_db.select(_db.reminders)
          ..where((tbl) => tbl.userId.equals(userId)))
        .get();
  }

  Future<void> updateReminder(ReminderModel reminder) async {
    print('ReminderRepository.updateReminder called for id: ${reminder.id}');
    final result = await (_db.update(_db.reminders)
          ..where((tbl) => tbl.id.equals(reminder.id)))
        .write(
      RemindersCompanion(
        title: Value(reminder.title),
        description: Value(reminder.description),
        reminderType: Value(reminder.reminderType),
        time: Value(reminder.dateTime),
        repeatDays: Value(reminder.repeatDays.join(',')),
        isActive: Value(reminder.isActive),
        updatedAt: Value(reminder.updatedAt),
      ),
    );
    print('ReminderRepository.updateReminder: Updated $result rows');
    await _db.into(_db.syncState).insertOnConflictUpdate(
          SyncStateCompanion.insert(
            userId: reminder.userId,
            targetTable: 'reminders',
            operation: 'update',
            lastUpdatedAt: reminder.updatedAt,
            lastSynced: Value(null),
            retryCount: const Value(0),
            error: const Value(null),
            rowId: reminder.id,
            isSynced: const Value(false),
          ),
        );
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
            lastSynced: Value(null),
            retryCount: const Value(0),
            error: const Value(null),
            rowId: reminder.id,
            isSynced: const Value(false),
          ),
        );
  }
}
