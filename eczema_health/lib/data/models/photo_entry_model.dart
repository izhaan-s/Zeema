class PhotoEntryModel {
    final String id;
    final String userId;
    final String imageURL;
    final String bodyPart;
    final int itchIntensity;
    final String? notes;
    final DateTime createdAt;
    final DateTime updatedAt;

    PhotoEntryModel({
        required this.id,
        required this.userId,
        required this.imageURL,
        required this.bodyPart,
        required this.itchIntensity,
        this.notes,
        required this.createdAt,
        required this.updatedAt,
    });

    factory PhotoEntryModel.fromJson(Map<String, dynamic> json) {
        return PhotoEntryModel(
            id: json['id'],
            userId: json['user_id'],
            imageURL: json['image_url'],
            bodyPart: json['body_part'],
            itchIntensity: json['itch_intensity'],
            notes: json['notes'],
            createdAt: DateTime.parse(json['created_at']),
            updatedAt: DateTime.parse(json['updated_at'])
        );
    }

    Map<String, dynamic> toJson() {
        return {
            'id': id,
            'user_id': userId,
            'image_url': imageURL,
            'body_part': bodyPart,
            'itch_intensity': itchIntensity,
            'notes': notes,
            'created_at': createdAt.toIso8601String(),
            'updated_at': updatedAt.toIso8601String()
        };
    }
}

// Might have to adapt image loading logic to work with this model as data will be stored in supabase storage
// Plan is users can enter several photos at once but each photo will be stored in a different entity