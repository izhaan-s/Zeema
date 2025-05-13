import 'package:drift/drift.dart';
import '../../local/app_database.dart';
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
  }

  // Delete a medication
  Future<void> deleteMedication(String id) async {
    await (_db.delete(_db.medications)..where((tbl) => tbl.id.equals(id))).go();
  }
}
