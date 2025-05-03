import 'package:eczema_health/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/photo_entry_model.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

// Update this later as we need to make it so that the image is uploaded as a path
// Rather than it being uploaded as a temp link
// Path -> function which creates the signed URL

class PhotoRepository {
  final SupabaseClient _supabase;
  static const String _bucketName = 'eczema-photos';

  PhotoRepository({SupabaseClient? supabase})
      : _supabase = supabase ?? Supabase.instance.client;

  Future<PhotoEntryModel> uploadPhoto({
    required File photoFile,
    required String bodyPart,
    required int itchIntensity,
    List<String>? notes,
  }) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      // Creates unique file name and uploads to users ID folder
      final uuid = const Uuid().v4();
      final date = DateTime.now();
      final fileExt = path.extension(photoFile.path);
      final fileName = '$userId/$date/$uuid$fileExt';

      // Upload here to storage bucket
      await supabase.storage.from(_bucketName).upload(fileName, photoFile);

      // Creates secure URL which is valid for 1 hour
      final imageURL = await _supabase.storage
          .from(_bucketName)
          .createSignedUrl(fileName, 3600);

      // Creates photo entry model to upload to DB
      final now = DateTime.now().toUtc();
      final photoEntry = PhotoEntryModel(
        id: uuid,
        userId: userId,
        imageUrl: imageURL,
        bodyPart: bodyPart,
        itchIntensity: itchIntensity,
        notes: notes,
        createdAt: now,
        updatedAt: now,
      );

      final data = await _supabase
          .from('photos')
          .insert(photoEntry.toMap())
          .select()
          .single();

      return PhotoEntryModel.fromMap(data);
    } catch (e) {
      print("Error in PhotoRepository.uploadPhoto: $e");
      rethrow;
    }
  }
}
