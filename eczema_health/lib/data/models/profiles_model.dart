class ProfilesModel {
  final String id;
  final String email;
  final String displayName;
  final String firstName;
  final String lastName;
  final String? avatarUrl;
  final DateTime dateOfBirth;
  final List<String> knownAllergies;
  final List<String> medicalNotes;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProfilesModel({
    required this.id,
    required this.email,
    required this.displayName,
    required this.firstName,
    required this.lastName,
    this.avatarUrl,
    required this.dateOfBirth,
    required this.knownAllergies,
    required this.medicalNotes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProfilesModel.fromMap(Map<String, dynamic> map) {
    return ProfilesModel(
      id: map['id'] as String,
      email: map['email'] as String,
      displayName: map['display_name'] as String,
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      avatarUrl: map['avatar_url'] as String?,
      dateOfBirth: DateTime.parse(map['date_of_birth'] as String),
      knownAllergies: List<String>.from(map['known_allergies'] ?? []),
      medicalNotes: List<String>.from(map['medical_notes'] ?? []),
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'id': id,
      'email': email,
      'display_name': displayName,
      'first_name': firstName,
      'last_name': lastName,
      'avatar_url': avatarUrl,
      'date_of_birth': dateOfBirth.toIso8601String(),
      'known_allergies': knownAllergies,
      'medical_notes': medicalNotes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
    // remove nulls for optional fields
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
