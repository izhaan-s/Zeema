import 'package:eczema_health/data/app_database.dart';
import 'package:drift/drift.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:convert';

class SyncServiceRevamped {
  final AppDatabase _db;
  final SupabaseClient _supabase;

  // Configuration constants
  static const int maxRetryCount = 3;
  static const int batchSize = 20;
  static const Duration highPriorityInterval = Duration(hours: 2);
  static const Duration normalPriorityInterval = Duration(hours: 6);

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
      print('⏭️  Sync skipped: No items to sync or timing conditions not met');
      return;
    }

    // Get items ready for retry (including items that failed but haven't exceeded retry limit)
    final unsyncedItems = await (_db.select(_db.syncState)
          ..where((t) =>
              t.isSynced.equals(false) &
              t.retryCount.isSmallerThanValue(maxRetryCount))
          ..orderBy([
            // Prioritize items with fewer retries first
            (t) => OrderingTerm.asc(t.retryCount),
            (t) => OrderingTerm.desc(t.lastUpdatedAt),
          ])
          ..limit(batchSize))
        .get();

    if (unsyncedItems.isEmpty) {
      // Check if there are items that exceeded retry limit
      final failedCount = await _getFailedItemsCount();
      if (failedCount > 0) {
        print(
            '📭 No items to sync - $failedCount items have exceeded retry limit');
      } else {
        print('📭 No unsynced items found');
      }
      return;
    }

    print('🚀 Syncing ${unsyncedItems.length} items...');
    int successCount = 0;
    int errorCount = 0;

    for (final item in unsyncedItems) {
      try {
        // Add exponential backoff delay for retries
        if (item.retryCount > 0) {
          final delaySeconds = (2 * item.retryCount).clamp(1, 30);
          print(
              '   ⏳ Retrying ${item.operation} ${item.targetTable}/${item.rowId} (attempt ${item.retryCount + 1}) after ${delaySeconds}s...');
          await Future.delayed(Duration(seconds: delaySeconds));
        }

        await _syncSingleItem(item);
        await _markAsSynced(item);
        successCount++;
        print('   ✅ ${item.operation} ${item.targetTable}/${item.rowId}');
      } catch (e) {
        await _updateSyncError(item, e.toString());
        errorCount++;
        print(
            '   ❌ ${item.operation} ${item.targetTable}/${item.rowId} (retry ${item.retryCount + 1}/$maxRetryCount): $e');
      }
    }

    print(
        '📊 Sync batch completed: $successCount successful, $errorCount failed');
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
          return row != null ? _convertToSupabaseFormat(row.toJson()) : null;
        case 'medications':
          final row = await (_db.select(_db.medications)
                ..where((t) => t.id.equals(rowId)))
              .getSingleOrNull();
          return row != null ? _convertToSupabaseFormat(row.toJson()) : null;
        case 'photos':
          final row = await (_db.select(_db.photos)
                ..where((t) => t.id.equals(rowId)))
              .getSingleOrNull();
          return row != null ? _convertToSupabaseFormat(row.toJson()) : null;
        case 'lifestyle_entries':
          final row = await (_db.select(_db.lifestyleEntries)
                ..where((t) => t.id.equals(rowId)))
              .getSingleOrNull();
          return row != null ? _convertToSupabaseFormat(row.toJson()) : null;
        case 'symptom_entries':
          final row = await (_db.select(_db.symptomEntries)
                ..where((t) => t.id.equals(rowId)))
              .getSingleOrNull();
          return row != null ? _convertToSupabaseFormat(row.toJson()) : null;
        case 'reminders':
          final row = await (_db.select(_db.reminders)
                ..where((t) => t.id.equals(rowId)))
              .getSingleOrNull();
          return row != null ? _convertToSupabaseFormat(row.toJson()) : null;
        case 'symptom_medication_links':
          final row = await (_db.select(_db.symptomMedicationLinks)
                ..where((t) => t.id.equals(rowId)))
              .getSingleOrNull();
          return row != null ? _convertToSupabaseFormat(row.toJson()) : null;
        default:
          return null;
      }
    } catch (e) {
      return null;
    }
  }

  /// Convert camelCase field names to snake_case for Supabase compatibility
  Map<String, dynamic> _convertToSupabaseFormat(Map<String, dynamic> data) {
    final converted = <String, dynamic>{};

    for (final entry in data.entries) {
      final snakeKey = _camelToSnakeCase(entry.key);
      dynamic value = entry.value;

      // Handle JSON string arrays - convert to proper arrays
      if (value is String && (value.startsWith('[') && value.endsWith(']'))) {
        try {
          // Parse JSON string to actual array
          final decoded = jsonDecode(value);
          if (decoded is List) {
            value = decoded;
          }
        } catch (e) {
          // If parsing fails, keep original value
        }
      }

      // Handle date/time fields - convert timestamps to ISO strings
      if (snakeKey.contains('_at') || snakeKey.contains('date')) {
        if (value is int) {
          // Convert millisecond timestamp to ISO string
          try {
            final dateTime = DateTime.fromMillisecondsSinceEpoch(value);
            value = dateTime.toIso8601String();
          } catch (e) {
            // If conversion fails, keep original value
          }
        } else if (value is String && value.isNotEmpty) {
          // Try to parse and reformat date strings
          try {
            final dateTime = DateTime.parse(value);
            value = dateTime.toIso8601String();
          } catch (e) {
            // If parsing fails, keep original value
          }
        }
      } else if (snakeKey == 'time') {
        // Handle time field specifically - extract only HH:mm:ss
        if (value is int) {
          try {
            final dateTime = DateTime.fromMillisecondsSinceEpoch(value);
            value =
                '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
          } catch (e) {
            // If conversion fails, keep original value
          }
        } else if (value is String && value.isNotEmpty) {
          try {
            final dateTime = DateTime.parse(value);
            value =
                '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
          } catch (e) {
            // If parsing fails, keep original value
          }
        }
      }

      // Handle null arrays - convert to empty array instead of null
      if (value == null &&
          (snakeKey.contains('areas') ||
              snakeKey.contains('symptoms') ||
              snakeKey.contains('notes'))) {
        value = <String>[];
      }

      converted[snakeKey] = value;
    }

    return converted;
  }

  /// Convert camelCase string to snake_case
  String _camelToSnakeCase(String camelCase) {
    return camelCase.replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => '_${match.group(0)!.toLowerCase()}',
    );
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

  Future<int> _getFailedItemsCount() async {
    final countExp = _db.syncState.rowId.count();
    final query = _db.selectOnly(_db.syncState)
      ..where(_db.syncState.isSynced.equals(false) &
          _db.syncState.retryCount.isBiggerOrEqualValue(maxRetryCount))
      ..addColumns([countExp]);

    final row = await query.getSingle();
    return row.read(countExp) ?? 0;
  }
}
