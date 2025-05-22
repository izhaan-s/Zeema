import 'dart:async';

import 'package:eczema_health/data/models/analysis_models.dart';
import 'package:eczema_health/data/repositories/cloud/analysis_repository.dart';
import 'package:eczema_health/data/repositories/local_storage/dashboard_cache_repository.dart';
import 'package:eczema_health/data/repositories/local_storage/symptom_repository.dart';
import 'package:eczema_health/features/dashboard/models/dashboard_data.dart';

/// Coordinates cloud and local repositories and maintains a cached copy of
/// dashboard‑wide analytics (severity trend, flare clusters, symptom matrix).
class DashboardService {
  final AnalysisRepository _cloudRepo;
  final LocalSymptomRepository _localRepo;
  final DashboardCacheRepository _cacheRepo;

  DashboardService({
    required AnalysisRepository cloudRepo,
    required LocalSymptomRepository localRepo,
    required DashboardCacheRepository cacheRepo,
  })  : _cloudRepo = cloudRepo,
        _localRepo = localRepo,
        _cacheRepo = cacheRepo;

  /* --------------------------------------------------------------------------
   * Public API
   * --------------------------------------------------------------------------*/

  /// Returns whatever we have in persistent cache — **without** checking
  /// freshness. Use when you want an immediate, best‑effort snapshot.
  Future<DashboardData?> getCachedData(String userId) async {
    return _cacheRepo.getDashboardCache(userId);
  }

  /// Returns a [DashboardData] snapshot, optionally forcing a refresh. The
  /// method consults the cache first and only hits the network when necessary
  /// (force refresh, stale cache, or new symptom entries).
  Future<DashboardData> getDashboardData(
    String userId, {
    bool forceRefresh = false,
  }) async {
    print('[DashboardService] 📦 getDashboardData called for $userId');
    final needsRefresh = await _needsDataRefresh(userId, forceRefresh);
    if (!needsRefresh) {
      final cached = await _cacheRepo.getDashboardCache(userId);
      if (cached != null) return cached;
    }

    // Cache miss or stale → fetch fresh.
    return _fetchAndCacheData(userId);
  }

  /// Clears the cached snapshot — call immediately after logging a new symptom
  /// so the next dashboard load is guaranteed fresh.
  Future<void> invalidateCache(String userId) async {
    await _cacheRepo.deleteDashboardCache(userId);
  }

  /* --------------------------------------------------------------------------
   * Internal helpers
   * --------------------------------------------------------------------------*/

  Future<bool> _needsDataRefresh(String userId, bool forceRefresh) async {
    if (forceRefresh) return true;

    final cached = await _cacheRepo.getDashboardCache(userId);
    if (cached == null) return true;

    final now = DateTime.now();
    final age = now.difference(cached.lastUpdated);
    print('[DashboardService] Cache age for $userId: ${age.inMinutes} minutes');

    // Consider cache stale after 24 hours.
    if (cached.isStale(const Duration(hours: 24))) {
      print('[DashboardService] Cache is stale — refreshing.');
      return true;
    }

    // If the number of locally stored symptom entries changed, refetch.
    final entryCount = (await _localRepo.getSymptomEntries(userId)).length;
    final cachedCount = await _cacheRepo.getLastSymptomCount(userId);
    final isSymptomCountDifferent = cachedCount != entryCount;

    print(
        '[DashboardService] Entry count: $entryCount | Cached count: $cachedCount');
    if (isSymptomCountDifferent) {
      print('[DashboardService] Symptom count changed — refreshing.');
    }

    return isSymptomCountDifferent;
  }

  /// Pulls fresh analytics from the cloud, caches them, and returns the
  /// assembled [DashboardData].
  Future<DashboardData> _fetchAndCacheData(String userId) async {
    // Gather local symptom entries.
    final entries = await _localRepo.getSymptomEntries(userId);
    final currentSymptomCount = entries.length;

    print('[DashboardService] Entries count for $userId: $currentSymptomCount');

    // Short‑circuit: if the user has no entries yet there is nothing to
    // analyse. Return an empty dashboard snapshot but still cache it so we
    // don’t hit the cloud again on every reload.
    if (entries.isEmpty) {
      final empty = DashboardData(
        severityData: const [],
        flares: const [],
        symptomMatrix: const [],
        lastUpdated: DateTime.now(),
      );
      await _cacheRepo.saveDashboardCache(userId, empty, currentSymptomCount);
      print('[DashboardService] Cached empty DashboardData for $userId');
      return empty;
    }

    // Format payload expected by the API.
    final formatted = entries
        .map((e) => {
              'id': e.id,
              'user_id': e.userId,
              'date': e.date.toIso8601String(),
              'is_flareup': e.isFlareup,
              'severity': e.severity.toString(),
              'affected_areas': e.affectedAreas,
              'symptoms': e.symptoms ?? [],
              'medications': e.medications ?? [],
              'notes': e.notes ?? [],
              'created_at': e.createdAt.toIso8601String(),
              'updated_at': e.updatedAt.toIso8601String(),
            })
        .toList();

    // Fetch flare clusters and symptom matrix **in parallel**.
    late final List<FlareCluster> clusters;
    late final List<Map<String, double>> matrix;
    try {
      final results = await Future.wait([
        _cloudRepo.getFlareClusters(formatted),
        _cloudRepo.getSymptomMatrix(formatted),
      ]);
      clusters = results[0] as List<FlareCluster>;
      matrix = results[1] as List<Map<String, double>>;

      print('[DashboardService] Clusters count: ${clusters.length}');
      print('[DashboardService] Symptom matrix size: ${matrix.length}');
    } on TimeoutException catch (e) {
      print('[DashboardService] ⚠️  Cloud call timed out: $e');
      clusters = const [];
      matrix = const [];
    } catch (e, st) {
      print('[DashboardService] ❌  Cloud call failed: $e');
      print(st);
      clusters = const [];
      matrix = const [];
    }

    // Build severity trend locally.
    final severityData = entries
        .map(
          (e) => SeverityPoint(
            date: e.date,
            severity: int.tryParse(e.severity) ?? int.parse(e.severity),
          ),
        )
        .toList();

    print('[DashboardService] Final severity points: ${severityData.length}');

    final dashboard = DashboardData(
      severityData: severityData,
      flares: clusters,
      symptomMatrix: matrix,
      lastUpdated: DateTime.now(),
    );

    // Store snapshot together with the current symptom count so we can later
    // detect local changes.
    await _cacheRepo.saveDashboardCache(userId, dashboard, currentSymptomCount);

    print('[DashboardService] ✅ DashboardData cached for $userId');

    return dashboard;
  }
}
