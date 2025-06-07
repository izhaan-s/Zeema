import 'dart:convert';
import '../../local/app_database.dart';
import '../../../features/dashboard/models/dashboard_data.dart';
import '../../models/analysis_models.dart';

class DashboardCacheRepository {
  final AppDatabase _db;

  DashboardCacheRepository(this._db);

  // caches dashboard data from FastAPI for offline user + more
  // format of data is as follows:
  // {
  //   userId: "123",
  //   severityData: [
  //     {"date": "2021-01-01T00:00:00Z", "severity": 1},
  //     {"date": "2021-01-02T00:00:00Z", "severity": 2},
  //   ],
  //   flares: [
  //     {"start": "2021-01-01T00:00:00Z", "end": "2021-01-02T00:00:00Z", "duration": 1},
  //   ],
  //   symptomMatrix: [
  //     {"symptom": "itching", "severity": 1},
  //   ],
  //   lastUpdated: "2021-01-01T00:00:00Z",
  //   lastSymptomCount: 10,
  // }

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

  // get dashboard cache from local storage
  // returns in same format as above
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

  // get last symptom count from local storage
  Future<int?> getLastSymptomCount(String userId) async {
    final cache = await (_db.select(_db.dashboardCache)
          ..where((tbl) => tbl.userId.equals(userId)))
        .getSingleOrNull();
    return cache?.lastSymptomCount;
  }

  // delete dashboard cache from local storage
  Future<void> deleteDashboardCache(String userId) async {
    await (_db.delete(_db.dashboardCache)
          ..where((tbl) => tbl.userId.equals(userId)))
        .go();
  }
}
