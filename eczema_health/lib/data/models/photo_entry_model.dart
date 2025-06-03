class PhotoEntryModel {
  // url is stored as a string in the database to local storage

  final String id;
  final String userId;
  final String imageUrl;
  final String bodyPart;
  final int itchIntensity;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime date;

  PhotoEntryModel({
    required this.id,
    required this.userId,
    required this.imageUrl,
    required this.bodyPart,
    required this.itchIntensity,
    this.notes,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PhotoEntryModel.fromMap(Map<String, dynamic> map) {
    return PhotoEntryModel(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      imageUrl: map['image_url'] as String,
      bodyPart: map['body_part'] as String,
      itchIntensity: map['itch_intensity'] as int,
      notes: map['notes'] != null ? map['notes'] as String : null,
      date: DateTime.parse(map['date'] as String),
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'id': id,
      'user_id': userId,
      'image_url': imageUrl,
      'body_part': bodyPart,
      'itch_intensity': itchIntensity,
      'date': date.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
    if (notes != null) {
      map['notes'] = notes;
    }
    return map;
  }
}
