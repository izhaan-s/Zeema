import 'package:eczema_health/data/repositories/cloud/analysis_repository.dart';
import 'package:eczema_health/data/repositories/local_storage/symptom_repository.dart';
import 'package:eczema_health/data/repositories/local_storage/dashboard_cache_repository.dart';
import 'package:eczema_health/data/models/analysis_models.dart';
import 'package:eczema_health/features/dashboard/models/dashboard_data.dart';

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

  // Get dashboard data, using cache if possible
  Future<DashboardData> getDashboardData(String userId,
      {bool forceRefresh = false}) async {
    // Check if we need to refresh the data
    final needsRefresh = await _needsDataRefresh(userId, forceRefresh);

    // Return cached data if it's still valid
    if (!needsRefresh) {
      final cachedData = await _cacheRepo.getDashboardCache(userId);
      if (cachedData != null) {
        return cachedData;
      }
    }

    // Otherwise, fetch fresh data
    return await _fetchAndCacheData(userId);
  }

  // Determine if we need to refresh the data
  Future<bool> _needsDataRefresh(String userId, bool forceRefresh) async {
    // Force refresh requested
    if (forceRefresh) return true;

    // Get cached data
    final cachedData = await _cacheRepo.getDashboardCache(userId);
    if (cachedData == null) return true;

    // Check if cache is stale (older than 24 hours)
    if (cachedData.isStale(const Duration(hours: 24))) return true;

    // Check if new symptoms have been added
    final currentSymptomCount =
        (await _localRepo.getSymptomEntries(userId)).length;
    final lastSymptomCount = await _cacheRepo.getLastSymptomCount(userId);
    if (lastSymptomCount != currentSymptomCount) {
      return true;
    }

    // Otherwise, use cache
    return false;
  }

  // Fetch fresh data and cache it
  Future<DashboardData> _fetchAndCacheData(String userId) async {
    // Get local symptom entries
    final entries = await _localRepo.getSymptomEntries(userId);
    final currentSymptomCount = entries.length;

    // Format entries for the API
    final formatted = entries
        .map((entry) => {
              'id': entry.id,
              'user_id': entry.userId,
              'date': entry.date.toIso8601String(),
              'is_flareup': entry.isFlareup,
              'severity': entry.severity.toString(),
              'affected_areas': entry.affectedAreas,
              'symptoms': entry.symptoms ?? [],
              'medications': entry.medications ?? [],
              'notes': entry.notes ?? [],
              'created_at': entry.createdAt.toIso8601String(),
              'updated_at': entry.updatedAt.toIso8601String(),
            })
        .toList();

    // Get flare clusters and symptom matrix from the cloud API
    List<FlareCluster> clusters = [];
    List<Map<String, double>> symptomMatrix = [];

    if (!entries.isEmpty) {
      clusters = await _cloudRepo.getFlareClusters(formatted);
      symptomMatrix = await _cloudRepo.getSymptomMatrix(formatted);
    }

    // Create severity data points
    final severityData = entries
        .map((e) => SeverityPoint(
              date: e.date,
              severity: int.parse(e.severity),
            ))
        .toList();

    // Create and cache the result
    final dashboardData = DashboardData(
      severityData: severityData,
      flares: clusters,
      symptomMatrix: symptomMatrix,
      lastUpdated: DateTime.now(),
    );

    // Save to persistent cache
    await _cacheRepo.saveDashboardCache(
        userId, dashboardData, currentSymptomCount);

    return dashboardData;
  }

  // Call this when a new symptom is added
  Future<void> invalidateCache(String userId) async {
    await _cacheRepo.deleteDashboardCache(userId);
  }
}
