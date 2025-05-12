import 'package:drift/drift.dart';
import '../../local/app_database.dart';
import '../../models/symptom_entry_model.dart';

class LocalSymptomRepository {
  final AppDatabase _db;

  LocalSymptomRepository(this._db);

  // Create
  Future<void> addSymptomEntry(SymptomEntryModel entry) async {
    try {
      await _db.into(_db.symptomEntries).insert(
            SymptomEntriesCompanion.insert(
              id: entry.id,
              userId: entry.userId,
              date: entry.date,
              isFlareup: entry.isFlareup,
              severity: entry.severity,
              affectedAreas: entry.affectedAreas.join(','),
              symptoms: Value(entry.symptoms?.join(',')),
              notes: Value(entry.notes?.join(',')),
              createdAt: entry.createdAt,
              updatedAt: entry.updatedAt,
            ),
          );
    } catch (e) {
      throw Exception('Failed to add symptom entry: $e');
    }
  }

  // GET !!
  Future<List<SymptomEntryModel>> getSymptomEntries(String userId) async {
    try {
      final entries = await (_db.select(_db.symptomEntries)
            ..where((t) => t.userId.equals(userId)))
          .get();
      return entries
          .map((entry) => SymptomEntryModel(
                id: entry.id,
                userId: entry.userId,
                date: entry.date,
                isFlareup: entry.isFlareup,
                severity: entry.severity,
                affectedAreas: entry.affectedAreas.split(','),
                symptoms: entry.symptoms?.split(','),
                notes: entry.notes?.split(','),
                createdAt: entry.createdAt,
                updatedAt: entry.updatedAt,
              ))
          .toList();
    } catch (e) {
      throw Exception('Failed to get symptom entries: $e');
    }
  }

  //
  Future<void> updateSymptomEntry(SymptomEntryModel entry) async {
    try {
      await (_db.update(_db.symptomEntries)
            ..where((t) => t.id.equals(entry.id)))
          .write(
        SymptomEntriesCompanion(
          date: Value(entry.date),
          isFlareup: Value(entry.isFlareup),
          severity: Value(entry.severity),
          affectedAreas: Value(entry.affectedAreas.join(',')),
          symptoms: Value(entry.symptoms?.join(',')),
          notes: Value(entry.notes?.join(',')),
          updatedAt: Value(entry.updatedAt),
        ),
      );
    } catch (e) {
      throw Exception('Failed to update symptom entry: $e');
    }
  }

  // Delete
  Future<void> deleteSymptomEntry(String id) async {
    try {
      await (_db.delete(_db.symptomEntries)..where((t) => t.id.equals(id)))
          .go();
    } catch (e) {
      throw Exception('Failed to delete symptom entry: $e');
    }
  }

  // Custom Queries

  // Get entries by date range
  Future<List<SymptomEntryModel>> getSymptomEntriesByDateRange(
      DateTime start, DateTime end) async {
    try {
      final entries = await (_db.select(_db.symptomEntries)
            ..where((t) =>
                t.date.isBiggerOrEqualValue(start) &
                t.date.isSmallerOrEqualValue(end)))
          .get();
      return entries
          .map((entry) => SymptomEntryModel(
                id: entry.id,
                userId: entry.userId,
                date: entry.date,
                isFlareup: entry.isFlareup,
                severity: entry.severity,
                affectedAreas: entry.affectedAreas.split(','),
                symptoms: entry.symptoms?.split(','),
                notes: entry.notes?.split(','),
                createdAt: entry.createdAt,
                updatedAt: entry.updatedAt,
              ))
          .toList();
    } catch (e) {
      throw Exception('Failed to get symptom entries by date range: $e');
    }
  }

  // Get entries by severity
  Future<List<SymptomEntryModel>> getSymptomEntriesBySeverity(
      String severity) async {
    try {
      final entries = await (_db.select(_db.symptomEntries)
            ..where((t) => t.severity.equals(severity)))
          .get();
      return entries
          .map((entry) => SymptomEntryModel(
                id: entry.id,
                userId: entry.userId,
                date: entry.date,
                isFlareup: entry.isFlareup,
                severity: entry.severity,
                affectedAreas: entry.affectedAreas.split(','),
                symptoms: entry.symptoms?.split(','),
                notes: entry.notes?.split(','),
                createdAt: entry.createdAt,
                updatedAt: entry.updatedAt,
              ))
          .toList();
    } catch (e) {
      throw Exception('Failed to get symptom entries by severity: $e');
    }
  }

  // Get flare-up entries
  Future<List<SymptomEntryModel>> getFlareupEntries() async {
    try {
      final entries = await (_db.select(_db.symptomEntries)
            ..where((t) => t.isFlareup.equals(true)))
          .get();
      return entries
          .map((entry) => SymptomEntryModel(
                id: entry.id,
                userId: entry.userId,
                date: entry.date,
                isFlareup: entry.isFlareup,
                severity: entry.severity,
                affectedAreas: entry.affectedAreas.split(','),
                symptoms: entry.symptoms?.split(','),
                notes: entry.notes?.split(','),
                createdAt: entry.createdAt,
                updatedAt: entry.updatedAt,
              ))
          .toList();
    } catch (e) {
      throw Exception('Failed to get flare-up entries: $e');
    }
  }
}
