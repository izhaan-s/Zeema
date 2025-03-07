class ProfilesModel {
  final String id;
  final String email;
  final String displayName;
  final String firstName;
  final String lastName;
  final String? avatarURL;
  final DateTime dateOfBirth;
  final List knownAllergies;
  final List medicalNotes;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProfilesModel({
    required this.id,
    required this.email,
    required this.displayName,
    required this.firstName,
    required this.lastName,
    this.avatarURL,
    required this.dateOfBirth,
    required this.knownAllergies,
    required this.medicalNotes,
    required this.createdAt,
    required this.updatedAt
  });

  factory ProfilesModel.fromJson(Map<String, dynamic> json) {
    return ProfilesModel(
      id: json['id'],
      email: json['email'],
      displayName: json['displayName'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      avatarURL: json['avatarURL'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      knownAllergies: json['knownAllergies'],
      medicalNotes: json['medicalNotes'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'firstName': firstName,
      'lastName': lastName,
      'avatarURL': avatarURL,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'knownAllergies': knownAllergies,
      'medicalNotes': medicalNotes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String()
    };
  }
}