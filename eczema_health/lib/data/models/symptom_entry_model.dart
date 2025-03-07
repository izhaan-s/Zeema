class SymptomEntryModel {
  final String id;
  final String userId;
  final DateTime date;
  final bool isFlareup;
  final String severity;
  final List affectedAreas;
  final String? symptoms;
  final String? notes;
  final DateTime createdAt;

  SymptomEntryModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.isFlareup,
    required this.severity,
    required this.affectedAreas,
    this.symptoms,
    this.notes,
    required this.createdAt
  });
  
  factory SymptomEntryModel.fromJson(Map<String, dynamic> json) {
    return SymptomEntryModel(
      id: json['id'],
      userId: json['userId'],
      date: DateTime.parse(json['date']),
      isFlareup: json['isFlareup'],
      severity: json['severity'],
      affectedAreas: json['affectedAreas'],
      symptoms: json['symptoms'],
      notes: json['notes'],
      createdAt: DateTime.parse(json['createdAt'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'date': date.toIso8601String(),
      'isFlareup': isFlareup,
      'severity': severity,
      'affectedAreas': affectedAreas,
      'symptoms': symptoms,
      'notes': notes,
      'createdAt': createdAt.toIso8601String()
    };
  }
}