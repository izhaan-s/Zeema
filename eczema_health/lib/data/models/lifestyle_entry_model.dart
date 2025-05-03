class LifestyleEntryModel {
  final String id;
  final String userId;
  final DateTime date;
  final List<String> foodsConsumed;
  final List<String> potentialTriggerFoods;
  final int sleepHours;
  final int sleepQuality;
  final int stressLevel;
  final double waterIntakeLiters;
  final int exerciseMinutes;
  final List<String>? notes;
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
    required this.exerciseMinutes,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  LifestyleEntryModel.fromMap(Map<String, dynamic> map)
      : id = map['id'] as String,
        userId = map['user_id'] as String,
        date = DateTime.parse(map['date'] as String),
        foodsConsumed = List<String>.from(map['foods_consumed'] ?? []),
        potentialTriggerFoods =
            List<String>.from(map['potential_trigger_foods'] ?? []),
        sleepHours = map['sleep_hours'] as int,
        sleepQuality = map['sleep_quality'] as int,
        stressLevel = map['stress_level'] as int,
        waterIntakeLiters = map['water_intake_liters'] as double,
        exerciseMinutes = map['exercise_minutes'] as int,
        notes = List<String>.from(map['notes'] ?? []),
        createdAt = DateTime.parse(map['created_at'] as String),
        updatedAt = DateTime.parse(map['updated_at'] as String);

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'id': id,
      'user_id': userId,
      'date': date.toIso8601String(),
      'foods_consumed': foodsConsumed,
      'potential_trigger_foods': potentialTriggerFoods,
      'sleep_hours': sleepHours,
      'sleep_quality': sleepQuality,
      'stress_level': stressLevel,
      'water_intake_liters': waterIntakeLiters,
      'exercise_minutes': exerciseMinutes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
    if (notes != null) {
      map['notes'] = notes;
    }
    return map;
  }
}
