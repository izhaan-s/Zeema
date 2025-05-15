class ReminderModel {
  final String id;
  final String userId;
  final String title;
  final String? description;
  final String? reminderType;
  final DateTime dateTime;
  final List<String> repeatDays;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  ReminderModel({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    this.reminderType,
    required this.dateTime,
    required this.repeatDays,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReminderModel.fromMap(Map<String, dynamic> map) {
    return ReminderModel(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      title: map['title'] as String,
      description: map['description'] as String?,
      reminderType: map['reminder_type'] as String?,
      dateTime: DateTime.parse("1970-01-01T${map['time']}"), // placeholder date
      repeatDays: (map['repeat_days'] as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      isActive: map['is_active'] as bool,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'id': "b5dddb02-ce34-4098-a20e-ebb6ea6e634d", // HARD CODED FOR NOW
      'user_id': userId,
      'title': title,
      'description': description,
      'reminder_type': reminderType,
      'time': dateTime.toIso8601String(),
      'repeat_days': repeatDays,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
    // Remove nulls for optional fields
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
