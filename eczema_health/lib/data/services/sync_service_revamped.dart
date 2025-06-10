import 'package:eczema_health/data/app_database.dart';
import 'package:drift/drift.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SyncServiceRevamped {
  final AppDatabase _db;
  final SupabaseClient _supabase;

  // Configuration constants
  static const int maxRetryCount = 3;
  static const int batchSize = 50;
  static const Duration highPriorityInterval = Duration(minutes: 30);
  static const Duration normalPriorityInterval = Duration(hours: 24);

  SyncServiceRevamped({
    required AppDatabase db,
    required SupabaseClient supabase,
  })  : _db = db,
        _supabase = supabase;

  Future<DateTime?> lastSync() async {
    final latestSync = await (_db.select(_db.syncState)
          ..orderBy([(t) => OrderingTerm.desc(t.lastUpdatedAt)])
          ..limit(1))
        .getSingleOrNull();

    if (latestSync == null) {
      return null;
    }

    return latestSync.lastSynced;
  }

  Future<int> numberOfUnsyncedItems() async {
    final countExp = _db.syncState.rowId.count();
    final query = _db.selectOnly(_db.syncState)
      ..where(_db.syncState.isSynced.equals(false))
      ..addColumns([countExp]);

    final row = await query.getSingle();
    return row.read(countExp) ?? 0;
  }

  Future<bool> shouldSync({bool forceSync = false}) async {
    if (forceSync) return true;

    final unsyncedCount = await numberOfUnsyncedItems();
    if (unsyncedCount == 0) return false;

    // Sync if we have enough items to batch
    if (unsyncedCount >= batchSize) return true;

    // Check time-based sync
    final lastSynced = await lastSync();
    if (lastSynced == null) return true;

    final timeSinceLastSync = DateTime.now().difference(lastSynced);
    return timeSinceLastSync >= normalPriorityInterval;
  }

  Future<void> sync(bool forceSync) async {
    if (!await shouldSync(forceSync: forceSync)) {
      return;
    }

    final unsyncedItems = await (_db.select(_db.syncState)
          ..where((t) =>
              t.isSynced.equals(false) &
              t.retryCount.isSmallerThanValue(maxRetryCount))
          ..orderBy([(t) => OrderingTerm.desc(t.lastUpdatedAt)])
          ..limit(batchSize))
        .get();

    if (unsyncedItems.isEmpty) return;

    int successCount = 0;
    int errorCount = 0;

    for (final item in unsyncedItems) {
      try {
        await _syncSingleItem(item);
        await _markAsSynced(item);
        successCount++;
      } catch (e) {
        await _updateSyncError(item, e.toString());
        errorCount++;
        print('Error syncing item: $e');
      }
    }

    print('Sync completed: $successCount successful, $errorCount failed');
  }

  Future<void> _syncSingleItem(SyncStateData item) async {
    Map<String, dynamic>? data;

    // For delete operations, we don't need to fetch data
    if (item.operation != 'delete') {
      data = await _fetchRowData(item.targetTable, item.rowId);
      if (data == null) {
        throw Exception(
            'Row not found locally: ${item.targetTable}/${item.rowId}');
      }
    }

    switch (item.operation) {
      case 'insert':
        await _supabase.from(item.targetTable).insert(data!);
        break;
      case 'update':
        await _supabase
            .from(item.targetTable)
            .update(data!)
            .eq('id', item.rowId);
        break;
      case 'delete':
        await _supabase.from(item.targetTable).delete().eq('id', item.rowId);
        break;
      default:
        throw Exception('Unknown operation: ${item.operation}');
    }
  }

  Future<Map<String, dynamic>?> _fetchRowData(
      String tableName, String rowId) async {
    try {
      switch (tableName) {
        case 'profiles':
          final row = await (_db.select(_db.profiles)
                ..where((t) => t.id.equals(rowId)))
              .getSingleOrNull();
          return row?.toJson();
        case 'medications':
          final row = await (_db.select(_db.medications)
                ..where((t) => t.id.equals(rowId)))
              .getSingleOrNull();
          return row?.toJson();
        case 'photos':
          final row = await (_db.select(_db.photos)
                ..where((t) => t.id.equals(rowId)))
              .getSingleOrNull();
          return row?.toJson();
        case 'lifestyle_entries':
          final row = await (_db.select(_db.lifestyleEntries)
                ..where((t) => t.id.equals(rowId)))
              .getSingleOrNull();
          return row?.toJson();
        case 'symptom_entries':
          final row = await (_db.select(_db.symptomEntries)
                ..where((t) => t.id.equals(rowId)))
              .getSingleOrNull();
          return row?.toJson();
        case 'reminders':
          final row = await (_db.select(_db.reminders)
                ..where((t) => t.id.equals(rowId)))
              .getSingleOrNull();
          return row?.toJson();
        case 'symptom_medication_links':
          final row = await (_db.select(_db.symptomMedicationLinks)
                ..where((t) => t.id.equals(rowId)))
              .getSingleOrNull();
          return row?.toJson();
        default:
          return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> _markAsSynced(SyncStateData item) async {
    await (_db.update(_db.syncState)
          ..where((t) =>
              t.userId.equals(item.userId) &
              t.targetTable.equals(item.targetTable) &
              t.rowId.equals(item.rowId)))
        .write(SyncStateCompanion(
      isSynced: const Value(true),
      lastSynced: Value(DateTime.now()),
    ));
  }

  Future<void> _updateSyncError(SyncStateData item, String error) async {
    await (_db.update(_db.syncState)
          ..where((t) =>
              t.userId.equals(item.userId) &
              t.targetTable.equals(item.targetTable) &
              t.rowId.equals(item.rowId)))
        .write(SyncStateCompanion(
      retryCount: Value(item.retryCount + 1),
      error: Value(error),
    ));
  }

  /// Get sync statistics for debugging/monitoring
  Future<Map<String, int>> getSyncStats() async {
    final unsynced = await numberOfUnsyncedItems();

    final failedCountExp = _db.syncState.rowId.count();
    final failedQuery = _db.selectOnly(_db.syncState)
      ..where(_db.syncState.isSynced.equals(false) &
          _db.syncState.retryCount.isBiggerOrEqualValue(maxRetryCount))
      ..addColumns([failedCountExp]);

    final failedRow = await failedQuery.getSingle();
    final failed = failedRow.read(failedCountExp) ?? 0;

    return {
      'unsynced': unsynced,
      'failed': failed,
      'pending': unsynced - failed,
    };
  }

  /// Clear all successfully synced items older than specified duration
  Future<void> cleanupSyncedItems(
      {Duration olderThan = const Duration(days: 7)}) async {
    final cutoffDate = DateTime.now().subtract(olderThan);

    await (_db.delete(_db.syncState)
          ..where((t) =>
              t.isSynced.equals(true) &
              t.lastSynced.isSmallerThanValue(cutoffDate)))
        .go();
  }
}
