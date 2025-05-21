import 'dart:convert';
import '../../local/app_database.dart';
import '../../../features/dashboard/models/dashboard_data.dart';
import '../../models/analysis_models.dart';

class DashboardCacheRepository {
  final AppDatabase _db;

  DashboardCacheRepository(this._db);

  Future<void> saveDashboardCache(
      String userId, DashboardData data, int lastSymptomCount) async {
    await _db.into(_db.dashboardCache).insertOnConflictUpdate(
          DashboardCacheCompanion.insert(
            userId: userId,
            severityData: jsonEncode(data.severityData
                .map((point) => {
                      'date': point.date.toIso8601String(),
                      'severity': point.severity,
                    })
                .toList()),
            flares: jsonEncode(data.flares
                .map((flare) => {
                      'start': flare.start.toIso8601String(),
                      'end': flare.end.toIso8601String(),
                      'duration': flare.duration,
                    })
                .toList()),
            symptomMatrix: jsonEncode(data.symptomMatrix),
            lastUpdated: data.lastUpdated,
            lastSymptomCount: lastSymptomCount,
          ),
        );
  }

  Future<DashboardData?> getDashboardCache(String userId) async {
    final cache = await (_db.select(_db.dashboardCache)
          ..where((tbl) => tbl.userId.equals(userId)))
        .getSingleOrNull();

    if (cache == null) return null;

    return DashboardData(
      severityData: (jsonDecode(cache.severityData) as List)
          .map((point) => SeverityPoint(
                date: DateTime.parse(point['date']),
                severity: point['severity'],
              ))
          .toList(),
      flares: (jsonDecode(cache.flares) as List)
          .map((flare) => FlareCluster(
                start: DateTime.parse(flare['start']),
                end: DateTime.parse(flare['end']),
                duration: flare['duration'],
              ))
          .toList(),
      symptomMatrix: (jsonDecode(cache.symptomMatrix) as List)
          .map((e) => Map<String, double>.from(e))
          .toList(),
      lastUpdated: cache.lastUpdated,
    );
  }

  Future<int?> getLastSymptomCount(String userId) async {
    final cache = await (_db.select(_db.dashboardCache)
          ..where((tbl) => tbl.userId.equals(userId)))
        .getSingleOrNull();
    return cache?.lastSymptomCount;
  }

  Future<void> deleteDashboardCache(String userId) async {
    await (_db.delete(_db.dashboardCache)
          ..where((tbl) => tbl.userId.equals(userId)))
        .go();
  }
}
