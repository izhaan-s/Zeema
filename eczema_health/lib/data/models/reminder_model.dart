class ReminderModel {
  final String id;
  final String userId;
  final String title;
  final String? description;
  final String? reminderType;
  final DateTime dateTime;
  final List repeatDays;
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

  ReminderModel.fromMap(Map<String, dynamic> map)
      : id = map['id'] as String,
        userId = map['user_id'] as String,
        title = map['title'] as String,
        description = map['description'] as String?,
        reminderType = map['reminder_type'] as String?,
        dateTime = DateTime.parse(map['date_time'] as String),
        repeatDays = map['repeat_days'] as List,
        isActive = map['is_active'] as bool,
        createdAt = DateTime.parse(map['created_at'] as String),
        updatedAt = DateTime.parse(map['updated_at'] as String);

  Map<String, dynamic> toMap() => {
        'id': id,
        'user_id': userId,
        'title': title,
        'description': description,
        'reminder_type': reminderType,
        'date_time': dateTime.toIso8601String(),
        'repeat_days': repeatDays,
        'is_active': isActive,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };
      
    // Allows updating of reminders
    ReminderModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    String? reminderType,
    DateTime? dateTime,
    List? repeatDays,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ReminderModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      reminderType: reminderType ?? this.reminderType,
      dateTime: dateTime ?? this.dateTime,
      repeatDays: repeatDays ?? this.repeatDays,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
  
}
