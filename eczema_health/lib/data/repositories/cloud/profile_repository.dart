import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/profile_model.dart';

class ProfileRepository {
  final SupabaseClient _supabase;

  ProfileRepository({SupabaseClient? supabase})
      : _supabase = supabase ?? Supabase.instance.client;

  Future<ProfileModel?> getProfile(String userId) async {
    try {
      final response =
          await _supabase.from('profiles').select().eq('id', userId).single();

      return ProfileModel.fromMap(response);
    } catch (e) {
      print('Error fetching profile: $e');
      return null;
    }
  }

  Future<bool> updateProfile(ProfileModel profile) async {
    try {
      await _supabase.from('profiles').update({
        'first_name': profile.firstName,
        'last_name': profile.lastName,
        'display_name': profile.displayName,
        'date_of_birth': profile.dateOfBirth?.toIso8601String(),
        'known_allergies': profile.knownAllergies,
        'medical_notes': profile.medicalNotes,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', profile.id);

      return true;
    } catch (e) {
      print('Error updating profile: $e');
      return false;
    }
  }

  Future<String?> uploadAvatar(String userId, String filePath) async {
    try {
      final fileName = '$userId-${DateTime.now().millisecondsSinceEpoch}.jpg';
      final avatarPath = 'avatars/$fileName';

      await _supabase.storage
          .from('avatars')
          .upload(avatarPath, filePath as dynamic);

      final String publicUrl =
          _supabase.storage.from('avatars').getPublicUrl(avatarPath);

      await _supabase
          .from('profiles')
          .update({'avatar_url': publicUrl}).eq('id', userId);

      return publicUrl;
    } catch (e) {
      print('Error uploading avatar: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>> getProfileStatistics(String userId) async {
    try {
      // Get symptom stats
      final symptomsResponse = await _supabase
          .from('symptoms')
          .select('id, severity, is_flareup')
          .eq('user_id', userId);

      final symptoms = symptomsResponse as List<dynamic>;

      // Calculate statistics
      int totalSymptoms = symptoms.length;
      int flareupCount = symptoms.where((s) => s['is_flareup'] == true).length;
      double avgSeverity = totalSymptoms > 0
          ? symptoms
                  .map((s) => (s['severity'] as num).toDouble())
                  .reduce((a, b) => a + b) /
              totalSymptoms
          : 0.0;

      // Get photo count
      final photosResponse =
          await _supabase.from('photos').select('id').eq('user_id', userId);
      final photoCount = (photosResponse as List).length;

      // Get active reminders count
      final remindersResponse = await _supabase
          .from('reminders')
          .select('id')
          .eq('user_id', userId)
          .eq('is_active', true);
      final activeReminders = (remindersResponse as List).length;

      // Get medications count
      final medicationsResponse = await _supabase
          .from('medications')
          .select('id')
          .eq('user_id', userId);
      final activeMedications = (medicationsResponse as List).length;

      return {
        'totalSymptoms': totalSymptoms,
        'flareupCount': flareupCount,
        'averageSeverity': avgSeverity,
        'photoCount': photoCount,
        'activeReminders': activeReminders,
        'activeMedications': activeMedications,
      };
    } catch (e) {
      print('Error fetching statistics: $e');
      return {
        'totalSymptoms': 0,
        'flareupCount': 0,
        'averageSeverity': 0.0,
        'photoCount': 0,
        'activeReminders': 0,
        'activeMedications': 0,
      };
    }
  }
}
