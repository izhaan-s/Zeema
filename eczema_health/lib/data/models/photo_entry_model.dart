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
            userId: json['userId'],
            imageURL: json['imageURL'],
            bodyPart: json['bodyPart'],
            itchIntensity: json['itchIntensity'],
            notes: json['notes'],
            createdAt: DateTime.parse(json['createdAt']),
            updatedAt: DateTime.parse(json['updatedAt'])
        );
    }

    Map<String, dynamic> toJson() {
        return {
            'id': id,
            'userId': userId,
            'imageURL': imageURL,
            'bodyPart': bodyPart,
            'itchIntensity': itchIntensity,
            'notes': notes,
            'createdAt': createdAt.toIso8601String(),
            'updatedAt': updatedAt.toIso8601String()
        };
    }
}

// Might have to adapt image loading logic to work with this model as data will be stored in supabase storage
// Plan is users can enter several photos at once but each photo will be stored in a different entity