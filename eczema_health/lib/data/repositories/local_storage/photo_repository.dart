import 'package:eczema_health/data/local/app_database.dart';
import 'package:path/path.dart' as path;
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:eczema_health/data/models/photo_entry_model.dart';
// Folder structure:
// photos/{userId}_{bodyPart}.jpg

class PhotoRepository {
  final AppDatabase _db;
  final String _photosPath = 'photos';

  PhotoRepository(this._db);

  Future<void> savePhoto(String userId, String bodyPart, String imagePath,
      DateTime date, String? notes) async {
    final photoPath = await _getPhotoPath(userId, bodyPart);
    await File(imagePath).copy(photoPath);

    PhotoEntryModel photo = PhotoEntryModel(
      id: path.basenameWithoutExtension(photoPath),
      userId: userId,
      imageUrl: photoPath,
      bodyPart: bodyPart,
      itchIntensity: 0,
      notes: notes,
      date: date,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _db.into(_db.photoEntries).insert(photo);
  }

  Future<String> _getPhotoPath(String userId, String bodyPart) async {
    final dir = Directory(_photosPath);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return path.join(_photosPath, '${userId}_$bodyPart.jpg');
  }
}
