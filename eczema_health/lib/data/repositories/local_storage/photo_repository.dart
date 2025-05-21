import 'package:eczema_health/data/local/app_database.dart';
import 'package:path/path.dart' as path;
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:eczema_health/data/models/photo_entry_model.dart';
import 'package:path_provider/path_provider.dart';

// Folder structure:
// photos/{userId}_{bodyPart}.jpg

class PhotoRepository {
  final AppDatabase _db;
  final String _photosFolder = 'photos';
  bool _schemaVerified = false;

  PhotoRepository(this._db);

  Future<void> _verifyPhotoSchema() async {
    if (_schemaVerified) return;

    try {
      // Check for date column
      final result = await _db
          .customSelect(
            'PRAGMA table_info(photos)',
          )
          .get();

      bool hasDateColumn = false;

      for (var column in result) {
        final columnName = column.data['name'] as String?;
        if (columnName == 'date') {
          hasDateColumn = true;
          break;
        }
      }

      if (!hasDateColumn) {
        // Try to add the column
        await _db.customStatement(
          'ALTER TABLE photos ADD COLUMN date INTEGER',
        );
      }

      _schemaVerified = true;
    } catch (e) {
      // Error verifying schema
    }
  }

  Future<void> savePhoto(String userId, String bodyPart, String imagePath,
      DateTime date, String? notes) async {
    try {
      // Verify schema before attempting insert
      await _verifyPhotoSchema();

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

      // Use a simpler approach with named parameters for clarity
      final companion = PhotosCompanion.insert(
        id: photo.id,
        userId: photo.userId,
        imageUrl: photo.imageUrl,
        bodyPart: photo.bodyPart,
        itchIntensity: Value(photo.itchIntensity),
        notes: Value(photo.notes),
        date: date,
        createdAt: photo.createdAt,
        updatedAt: photo.updatedAt,
      );

      await _db.into(_db.photos).insert(companion);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> _getPhotoPath(String userId, String bodyPart) async {
    // Get the application documents directory
    final appDocDir = await getApplicationDocumentsDirectory();
    final photosDir = Directory('${appDocDir.path}/$_photosFolder');

    // Create the photos directory if it doesn't exist
    if (!await photosDir.exists()) {
      await photosDir.create(recursive: true);
    }

    // Create a unique filename
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final fileName = '${userId}_${bodyPart}_$timestamp.jpg';

    return path.join(photosDir.path, fileName);
  }

  Future<List<Map<String, String>>> getPhotos() async {
    await _verifyPhotoSchema();

    final result = await _db.select(_db.photos).get();
    return result
        .map((photo) => {
              'id': photo.id,
              'image': photo.imageUrl,
              'date': photo.date.toString(),
              'bodyPart': photo.bodyPart,
            })
        .toList();
  }
}
