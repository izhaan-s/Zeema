class SymptomEntryModel {
  final String id;
  final String userId;
  final DateTime date;
  final bool isFlareup;
  final String severity;
  final List<String> affectedAreas;
  final List<String>? symptoms;
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
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'date': date.toIso8601String(),
      'is_flareup': isFlareup,
      'severity': severity,
      'affected_areas': affectedAreas,
      'symptoms': symptoms,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory SymptomEntryModel.fromJson(Map<String, dynamic> json) {
    return SymptomEntryModel(
      id: json['id'],
      userId: json['user_id'],
      date: DateTime.parse(json['date']),
      isFlareup: json['is_flareup'],
      severity: json['severity'],
      affectedAreas: List<String>.from(json['affected_areas']),
      symptoms:
          json['symptoms'] != null ? List<String>.from(json['symptoms']) : null,
      notes: json['notes'] != null ? List<String>.from(json['notes']) : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
