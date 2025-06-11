import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'sync_service_revamped.dart';
import 'download_data.dart';
import 'package:eczema_health/data/app_database.dart';

/// Manages automatic and manual syncing with network awareness
class SyncManager {
  final SyncServiceRevamped _syncService;
  final AppDatabase _db;
  Timer? _periodicSyncTimer;
  bool _isOnline = true;
  bool _isSyncing = false;

  // Sync intervals
  static const Duration _quickSyncInterval = Duration(minutes: 5);
  static const Duration _normalSyncInterval = Duration(hours: 1);

  // Event streams
  final _syncStatusController = StreamController<SyncStatus>.broadcast();
  final _syncStatsController = StreamController<Map<String, int>>.broadcast();

  Stream<SyncStatus> get syncStatusStream => _syncStatusController.stream;
  Stream<Map<String, int>> get syncStatsStream => _syncStatsController.stream;

  SyncManager(this._syncService, this._db);

  /// Initialize the sync manager and start periodic syncing
  Future<void> initialize() async {
    print('🔧 Initializing Sync Manager...');
    await _updateSyncStats();
    _startPeriodicSync();

    // Listen to auth state changes
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      if (data.event == AuthChangeEvent.signedIn) {
        print('👤 User signed in - downloading and syncing data');
        _handleUserSignIn();
      } else if (data.event == AuthChangeEvent.signedOut) {
        print('👤 User signed out - stopping sync');
        _stopPeriodicSync();
      }
    });

    final initialStats = await _syncService.getSyncStats();
    print(
        '📊 Initial sync stats - Pending: ${initialStats['pending']}, Failed: ${initialStats['failed']}');
  }

  /// Handle user sign in - download data then start syncing
  Future<void> _handleUserSignIn() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) return;

    try {
      final downloadService = DownloadData(userId, _db);
      await downloadService.downloadAllUserData();

      _startPeriodicSync();
      triggerSync();
    } catch (e) {
      print('❌ Error during sign in sync: $e');
      _startPeriodicSync();
      triggerSync();
    }
  }

  /// Start periodic syncing based on current conditions
  void _startPeriodicSync() {
    _stopPeriodicSync(); // Stop any existing timer

    // Use quick sync if we have pending items, normal otherwise
    _syncService.numberOfUnsyncedItems().then((count) {
      final interval = count > 0 ? _quickSyncInterval : _normalSyncInterval;

      _periodicSyncTimer = Timer.periodic(interval, (_) async {
        if (_isOnline && !_isSyncing) {
          await _performSync(false);
        }
      });

      print('Periodic sync started with ${interval.inMinutes}min interval');
    });
  }

  /// Stop periodic syncing
  void _stopPeriodicSync() {
    _periodicSyncTimer?.cancel();
    _periodicSyncTimer = null;
  }

  /// Trigger immediate sync (can be called manually)
  Future<void> triggerSync({bool force = false}) async {
    if (_isSyncing && !force) {
      print('Sync already in progress, skipping...');
      return;
    }

    await _performSync(force);
  }

  /// Perform the actual sync operation
  Future<void> _performSync(bool force) async {
    if (!_isUserLoggedIn()) {
      print('🔒 Sync skipped: User not logged in');
      return;
    }

    final stats = await _syncService.getSyncStats();
    print(
        '🔄 Starting sync - Pending: ${stats['pending']}, Failed: ${stats['failed']}');

    _isSyncing = true;
    _syncStatusController.add(SyncStatus.syncing);

    try {
      await _syncService.sync(force);
      await _updateSyncStats();

      final newStats = await _syncService.getSyncStats();
      print(
          '✅ Sync completed - Pending: ${newStats['pending']}, Failed: ${newStats['failed']}');

      _syncStatusController.add(SyncStatus.success);

      // Restart timer with updated interval based on current sync state
      _startPeriodicSync();
    } catch (e) {
      print('❌ Sync failed: $e');
      _syncStatusController.add(SyncStatus.error);
    } finally {
      _isSyncing = false;
    }
  }

  /// Update and broadcast sync statistics
  Future<void> _updateSyncStats() async {
    try {
      final stats = await _syncService.getSyncStats();
      _syncStatsController.add(stats);
    } catch (e) {
      print('Failed to get sync stats: $e');
    }
  }

  /// Check if user is logged in
  bool _isUserLoggedIn() {
    return Supabase.instance.client.auth.currentUser != null;
  }

  /// Set network connectivity status
  void setNetworkStatus(bool isOnline) {
    final wasOffline = !_isOnline;
    _isOnline = isOnline;

    if (isOnline && wasOffline) {
      // Back online - trigger immediate sync
      print('Network restored, triggering sync...');
      triggerSync();
    } else if (!isOnline) {
      print('Network lost, pausing sync...');
    }
  }

  /// Get current sync statistics
  Future<Map<String, int>> getCurrentStats() async {
    return await _syncService.getSyncStats();
  }

  /// Clean up old synced items
  Future<void> cleanup() async {
    try {
      await _syncService.cleanupSyncedItems();
      await _updateSyncStats();
      print('Sync cleanup completed');
    } catch (e) {
      print('Sync cleanup failed: $e');
    }
  }

  /// Dispose of resources
  void dispose() {
    _stopPeriodicSync();
    _syncStatusController.close();
    _syncStatsController.close();
  }
}

/// Sync status enumeration
enum SyncStatus {
  idle,
  syncing,
  success,
  error,
}

/// Extension for sync status display
extension SyncStatusExtension on SyncStatus {
  String get displayName {
    switch (this) {
      case SyncStatus.idle:
        return 'Ready';
      case SyncStatus.syncing:
        return 'Syncing...';
      case SyncStatus.success:
        return 'Synced';
      case SyncStatus.error:
        return 'Error';
    }
  }
}
