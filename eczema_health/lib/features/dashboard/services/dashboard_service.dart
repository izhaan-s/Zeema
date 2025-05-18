import 'package:eczema_health/data/repositories/cloud/analysis_repository.dart';
import 'package:eczema_health/data/repositories/local_storage/symptom_repository.dart';
import 'package:eczema_health/data/models/analysis_models.dart';
import 'package:eczema_health/features/dashboard/models/dashboard_data.dart';

class DashboardService {
  final AnalysisRepository _cloudRepo;
  final LocalSymptomRepository _localRepo;

  // Cache the dashboard data
  DashboardData? _cachedData;

  // Track the last known symptom count to detect new additions
  int _lastSymptomCount = 0;

  DashboardService({
    required AnalysisRepository cloudRepo,
    required LocalSymptomRepository localRepo,
  })  : _cloudRepo = cloudRepo,
        _localRepo = localRepo;

  // Get dashboard data, using cache if possible
  Future<DashboardData> getDashboardData(String userId,
      {bool forceRefresh = false}) async {
    // Check if we need to refresh the data
    final needsRefresh = await _needsDataRefresh(userId, forceRefresh);

    // Return cached data if it's still valid
    if (!needsRefresh && _cachedData != null) {
      return _cachedData!;
    }

    // Otherwise, fetch fresh data
    return await _fetchAndCacheData(userId);
  }

  // Determine if we need to refresh the data
  Future<bool> _needsDataRefresh(String userId, bool forceRefresh) async {
    // Force refresh requested
    if (forceRefresh) return true;

    // No cached data yet
    if (_cachedData == null) return true;

    // Check if cache is stale (older than 24 hours)
    if (_cachedData!.isStale(const Duration(hours: 24))) return true;

    // Check if new symptoms have been added
    final currentSymptomCount =
        (await _localRepo.getSymptomEntries(userId)).length;
    if (currentSymptomCount != _lastSymptomCount) {
      // Update the count and refresh
      _lastSymptomCount = currentSymptomCount;
      return true;
    }

    // Otherwise, use cache
    return false;
  }

  // Fetch fresh data and cache it
  Future<DashboardData> _fetchAndCacheData(String userId) async {
    // Get local symptom entries
    final entries = await _localRepo.getSymptomEntries(userId);
    _lastSymptomCount = entries.length;

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

    // Get flare clusters from the cloud API
    final clusters = await _cloudRepo.getFlareClusters(formatted);

    // Create severity data points
    final severityData = entries
        .map((e) => SeverityPoint(
              date: e.date,
              severity: int.parse(e.severity),
            ))
        .toList();

    // Cache the result
    _cachedData = DashboardData(
      severityData: severityData,
      flares: clusters,
      lastUpdated: DateTime.now(),
    );

    return _cachedData!;
  }

  // Call this when a new symptom is added
  void invalidateCache() {
    _cachedData = null;
  }
}
