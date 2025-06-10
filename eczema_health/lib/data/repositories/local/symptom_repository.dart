import 'package:drift/drift.dart';
import '../../app_database.dart';
import '../../models/symptom_entry_model.dart';
import 'dart:convert';

class LocalSymptomRepository {
  final AppDatabase _db;

  LocalSymptomRepository(this._db);

  // Create
  Future<void> addSymptomEntry(SymptomEntryModel entry) async {
    await _db.transaction(() async {
      // Insert the symptom entry
      await _db.into(_db.symptomEntries).insert(
            SymptomEntriesCompanion.insert(
              id: entry.id,
              userId: entry.userId,
              date: entry.date,
              isFlareup: entry.isFlareup,
              severity: entry.severity,
              affectedAreas: jsonEncode(entry.affectedAreas),
              symptoms: Value(
                  entry.symptoms != null ? jsonEncode(entry.symptoms) : null),
              notes:
                  Value(entry.notes != null ? jsonEncode(entry.notes) : null),
              createdAt: entry.createdAt,
              updatedAt: entry.updatedAt,
            ),
          );

      // sync to sync service
      await _db.into(_db.syncState).insert(
            SyncStateCompanion.insert(
              userId: entry.userId,
              targetTable: 'symptom_entries',
              operation: 'insert',
              lastUpdatedAt: entry.updatedAt,
              lastSynced: Value(null),
              retryCount: const Value(0),
              error: const Value(null),
              rowId: entry.id,
              isSynced: const Value(false),
            ),
          );
      // If there are medications, create the links
      if (entry.medications != null && entry.medications!.isNotEmpty) {
        final links = entry.medications!.map((medicationId) {
          return SymptomMedicationLinksCompanion.insert(
            id: DateTime.now().millisecondsSinceEpoch.toString() +
                '_$medicationId',
            symptomId: entry.id,
            medicationId: medicationId,
            userId: entry.userId,
            createdAt: DateTime.now(),
          );
        }).toList();

        await _db.batch((batch) {
          batch.insertAll(_db.symptomMedicationLinks, links);
        });
      }
    });
  }

  // GET !!
  Future<List<SymptomEntryModel>> getSymptomEntries(String userId) async {
    final entries = await (_db.select(_db.symptomEntries)
          ..where((tbl) => tbl.userId.equals(userId)))
        .get();

    return entries.map((entry) {
      // Helper function to safely parse lists from either JSON or comma-separated strings
      List<String> parseList(String? value) {
        if (value == null) return [];
        try {
          // Try parsing as JSON first
          final decoded = jsonDecode(value);
          if (decoded is List) {
            return List<String>.from(decoded);
          }
        } catch (_) {
          // If JSON parsing fails, try splitting by comma
          return value.split(',').map((e) => e.trim()).toList();
        }
        return [];
      }

      return SymptomEntryModel(
        id: entry.id,
        userId: entry.userId,
        date: entry.date,
        isFlareup: entry.isFlareup,
        severity: entry.severity,
        affectedAreas: parseList(entry.affectedAreas),
        symptoms: entry.symptoms != null ? parseList(entry.symptoms) : null,
        notes: entry.notes != null ? parseList(entry.notes) : null,
        createdAt: entry.createdAt,
        updatedAt: entry.updatedAt,
      );
    }).toList();
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
          affectedAreas: Value(jsonEncode(entry.affectedAreas)),
          symptoms:
              Value(entry.symptoms != null ? jsonEncode(entry.symptoms) : null),
          notes: Value(entry.notes != null ? jsonEncode(entry.notes) : null),
          updatedAt: Value(entry.updatedAt),
        ),
      );

      // sync to sync service
      await _db.into(_db.syncState).insert(
            SyncStateCompanion.insert(
              userId: entry.userId,
              targetTable: 'symptom_entries',
              operation: 'update',
              lastUpdatedAt: entry.updatedAt,
              lastSynced: Value(null),
              retryCount: const Value(0),
              error: const Value(null),
              rowId: entry.id,
              isSynced: const Value(false),
            ),
          );
    } catch (e) {
      throw Exception('Failed to update symptom entry: $e');
    }
  }

  // Delete
  Future<void> deleteSymptomEntry(String id, SymptomEntryModel entry) async {
    await _db.transaction(() async {
      // sync removal of medication links
      await _db.into(_db.syncState).insert(
            SyncStateCompanion.insert(
              userId: entry.userId,
              targetTable: 'symptom_medication_links',
              operation: 'delete',
              lastUpdatedAt: entry.updatedAt,
              lastSynced: Value(null),
              retryCount: const Value(0),
              error: const Value(null),
              rowId: id,
              isSynced: const Value(false),
            ),
          );

      // Delete the symptom-medication links first
      await (_db.delete(_db.symptomMedicationLinks)
            ..where((tbl) => tbl.symptomId.equals(id)))
          .go();

      // Then delete the symptom entry
      await (_db.delete(_db.symptomEntries)..where((tbl) => tbl.id.equals(id)))
          .go();

      // sync to sync service
      await _db.into(_db.syncState).insert(
            SyncStateCompanion.insert(
              userId: entry.userId,
              targetTable: 'symptom_entries',
              operation: 'delete',
              lastUpdatedAt: entry.updatedAt,
              lastSynced: Value(null),
              retryCount: const Value(0),
              error: const Value(null),
              rowId: id,
              isSynced: const Value(false),
            ),
          );
    });
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

  Future<List<String>> getMedicationsForSymptom(String symptomId) async {
    final links = await (_db.select(_db.symptomMedicationLinks)
          ..where((tbl) => tbl.symptomId.equals(symptomId)))
        .get();

    return links.map((link) => link.medicationId).toList();
  }
}
