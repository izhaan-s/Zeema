// Medication / treatement such as creams, ointments, etc.

class MedicationEntry {
  final String id;
  final String userId;
  final String name;
  final String dosage; // Not sure could change this data type to double 
  final int frequency;
  final DateTime startDate;
  final DateTime endDate;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  MedicationEntry({
    required this.id,
    required this.userId,
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.startDate,
    required this.endDate,
    this.notes,
    required this.createdAt,
    required this.updatedAt
  });

  factory MedicationEntry.fromJson(Map<String, dynamic> json) {
    return MedicationEntry(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      dosage: json['dosage'],
      frequency: json['frequency'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      notes: json['notes'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'dosage': dosage,
      'frequency': frequency,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String()
    };
  }
}