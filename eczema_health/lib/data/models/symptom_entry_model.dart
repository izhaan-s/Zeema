class SymptomEntryModel {
  final String id;
  final String userId;
  final DateTime date;
  final bool isFlareup;
  final String severity;
  final List<String> affectedAreas;
  final List<String>? symptoms;
  final List<String>? medications;
  final List<String>? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  SymptomEntryModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.isFlareup,
    required this.severity,
    required this.affectedAreas,
    this.symptoms,
    this.medications,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SymptomEntryModel.fromMap(Map<String, dynamic> map) {
    return SymptomEntryModel(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      date: DateTime.parse(map['date'] as String),
      isFlareup: map['is_flareup'] as bool,
      severity: map['severity'] as String,
      affectedAreas: List<String>.from(map['affected_areas']),
      symptoms:
          map['symptoms'] != null ? List<String>.from(map['symptoms']) : null,
      medications: map['medications'] != null
          ? List<String>.from(map['medications'])
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
      'date': date.toIso8601String(),
      'is_flareup': isFlareup,
      'severity': severity,
      'affected_areas': affectedAreas,
      'symptoms': symptoms,
      'medications': medications,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
    // Remove nulls for optional fields
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
