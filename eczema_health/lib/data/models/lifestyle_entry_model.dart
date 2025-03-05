class LifestyleEntryModel {
  final String id;
  final String userId;
  final DateTime date;
  final String foodsConsumed;
  final String potentialTriggerFoods;
  final int sleepHours;
  final String sleepQuality;
  final int stressLevel;
  final double waterIntakeLiters;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  LifestyleEntryModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.foodsConsumed,
    required this.potentialTriggerFoods,
    required this.sleepHours,
    required this.sleepQuality,
    required this.stressLevel,
    required this.waterIntakeLiters,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  LifestyleEntryModel.fromMap(Map<String, dynamic> map)
      : id = map['id'] as String,
        userId = map['user_id'] as String,
        date = DateTime.parse(map['date'] as String),
        foodsConsumed = map['foods_consumed'] as String,
        potentialTriggerFoods = map['potential_trigger_foods'] as String,
        sleepHours = map['sleep_hours'] as int,
        sleepQuality = map['sleep_quality'] as String,
        stressLevel = map['stress_level'] as int,
        waterIntakeLiters = map['water_intake_liters'] as double,
        notes = map['notes'] as String?,
        createdAt = DateTime.parse(map['created_at'] as String),
        updatedAt = DateTime.parse(map['updated_at'] as String);

  Map<String, dynamic> toMap() => {
        'id': id,
        'user_id': userId,
        'date': date.toIso8601String(),
        'foods_consumed': foodsConsumed,
        'potential_trigger_foods': potentialTriggerFoods,
        'sleep_hours': sleepHours,
        'sleep_quality': sleepQuality,
        'stress_level': stressLevel,
        'water_intake_liters': waterIntakeLiters,
        'notes': notes,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String,
      };
}
