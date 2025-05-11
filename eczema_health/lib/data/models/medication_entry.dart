class MedicationEntryModel {
  final String id;
  final String userId;
  final String name;
  final String dosage;
  final String frequency;
  final DateTime startDate;
  final DateTime? endDate;
  final int? effectiveness;
  final List<String>? sideEffects;
  final List<String>? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  MedicationEntryModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.startDate,
    this.endDate,
    this.effectiveness,
    this.sideEffects,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MedicationEntryModel.fromMap(Map<String, dynamic> map) {
    return MedicationEntryModel(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      name: map['name'] as String,
      dosage: map['dosage'] as String,
      frequency: map['frequency'] as String,
      startDate: DateTime.parse(map['start_date'] as String),
      endDate: map['end_date'] != null
          ? DateTime.parse(map['end_date'] as String)
          : null,
      effectiveness: map['effectiveness'] as int?,
      sideEffects: map['side_effects'] != null
          ? List<String>.from(map['side_effects'])
          : null,
      notes: map['notes'] != null ? List<String>.from(map['notes']) : null,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'id': id,
      'user_id': userId,
      'name': name,
      'dosage': dosage,
      'frequency': frequency,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'effectiveness': effectiveness,
      'side_effects': sideEffects,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
    // Remove nulls for optional fields
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
