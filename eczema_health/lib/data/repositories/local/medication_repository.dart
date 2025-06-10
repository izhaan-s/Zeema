import 'package:drift/drift.dart';
import '../../app_database.dart';
import 'dart:convert';

class LocalMedicationRepository {
  final AppDatabase _db;

  LocalMedicationRepository(this._db);

  // Get all user medications
  Future<List<Medication>> getUserMedications(String userId) async {
    return await (_db.select(_db.medications)
          ..where((tbl) => tbl.userId.equals(userId)))
        .get();
  }

  // Add a new medication
  Future<void> addMedication(Map<String, dynamic> medication) async {
    await _db.into(_db.medications).insert(
          MedicationsCompanion.insert(
            id: medication['id'],
            userId: medication['userId'],
            name: medication['name'],
            dosage: medication['dosage'].toString(),
            frequency: medication['frequency'].toString(),
            startDate: DateTime.parse(medication['startDate']),
            endDate: medication['endDate'] != null
                ? Value(DateTime.parse(medication['endDate']))
                : const Value.absent(),
            effectiveness: medication['effectiveness'] != null
                ? Value(medication['effectiveness'])
                : const Value.absent(),
            sideEffects: medication['sideEffects'] != null
                ? Value(jsonEncode(medication['sideEffects']))
                : const Value.absent(),
            notes: medication['notes'] != null
                ? Value(jsonEncode(medication['notes']))
                : const Value.absent(),
            isPreloaded: medication['isPreloaded'] ?? false,
            isSteroid: medication['isSteroid'] ?? false,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );

    await _db.into(_db.syncState).insertOnConflictUpdate(
          SyncStateCompanion.insert(
            userId: medication['userId'],
            targetTable: 'medications',
            operation: 'insert',
            lastUpdatedAt: DateTime.now(),
            lastSynced: Value(null),
            retryCount: const Value(0),
            error: const Value(null),
            rowId: medication['id'],
            isSynced: const Value(false),
          ),
        );
  }

  // Update an existing medication
  Future<void> updateMedication(
      String id, Map<String, dynamic> medication) async {
    await (_db.update(_db.medications)..where((tbl) => tbl.id.equals(id)))
        .write(
      MedicationsCompanion(
        name: Value(medication['name']),
        dosage: Value(medication['dosage'].toString()),
        frequency: Value(medication['frequency'].toString()),
        startDate: Value(DateTime.parse(medication['startDate'])),
        endDate: medication['endDate'] != null
            ? Value(DateTime.parse(medication['endDate']))
            : const Value.absent(),
        effectiveness: medication['effectiveness'] != null
            ? Value(medication['effectiveness'])
            : const Value.absent(),
        sideEffects: medication['sideEffects'] != null
            ? Value(jsonEncode(medication['sideEffects']))
            : const Value.absent(),
        notes: medication['notes'] != null
            ? Value(jsonEncode(medication['notes']))
            : const Value.absent(),
        isPreloaded: Value(medication['isPreloaded'] ?? false),
        isSteroid: Value(medication['isSteroid'] ?? false),
        updatedAt: Value(DateTime.now()),
      ),
    );

    await _db.into(_db.syncState).insertOnConflictUpdate(
          SyncStateCompanion.insert(
            userId: medication['userId'],
            targetTable: 'medications',
            operation: 'update',
            lastUpdatedAt: DateTime.now(),
            lastSynced: Value(null),
            retryCount: const Value(0),
            error: const Value(null),
            rowId: id,
            isSynced: const Value(false),
          ),
        );
  }

  // Delete a medication
  Future<void> deleteMedication(
      String id, Map<String, dynamic> medication) async {
    await (_db.delete(_db.medications)..where((tbl) => tbl.id.equals(id))).go();

    await _db.into(_db.syncState).insertOnConflictUpdate(
          SyncStateCompanion.insert(
            userId: medication['userId'],
            targetTable: 'medications',
            operation: 'delete',
            lastUpdatedAt: DateTime.now(),
            lastSynced: Value(null),
            retryCount: const Value(0),
            error: const Value(null),
            rowId: id,
            isSynced: const Value(false),
          ),
        );
  }
}
