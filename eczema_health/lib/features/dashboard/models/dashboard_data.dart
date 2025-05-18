import 'package:eczema_health/data/models/analysis_models.dart';

/// Model to store and cache dashboard data
class DashboardData {
  final List<SeverityPoint> severityData;
  final List<FlareCluster> flares;
  final DateTime lastUpdated;
  final List<Map<String, double>> symptomMatrix;

  DashboardData({
    required this.severityData,
    required this.flares,
    required this.lastUpdated,
    required this.symptomMatrix,
  });

  // Check if data is stale (older than the specified duration)
  bool isStale(Duration stalePeriod) {
    return DateTime.now().difference(lastUpdated) > stalePeriod;
  }
}
