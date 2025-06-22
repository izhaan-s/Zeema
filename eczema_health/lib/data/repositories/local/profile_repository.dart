// Debug: Local Profile Repository - handles profile data from local database for offline support
import '../../app_database.dart';
import '../../models/profile_model.dart';
import 'dart:convert';
import 'package:drift/drift.dart';

class LocalProfileRepository {
  final AppDatabase _db;

  LocalProfileRepository(this._db);

  // Debug: Get profile from local database
  Future<ProfileModel?> getProfile(String userId) async {
    try {
      print('🔍 LocalProfileRepository: Fetching profile for user $userId');

      final profile = await (_db.select(_db.profiles)
            ..where((t) => t.id.equals(userId)))
          .getSingleOrNull();

      if (profile == null) {
        print('❌ LocalProfileRepository: No profile found in local database');
        return null;
      }

      print('✅ LocalProfileRepository: Profile found locally');
      return ProfileModel.fromMap(_convertProfileToMap(profile));
    } catch (e) {
      print('❌ LocalProfileRepository: Error fetching profile: $e');
      return null;
    }
  }

  // Debug: Get profile statistics from local database
  Future<Map<String, dynamic>> getProfileStatistics(String userId) async {
    try {
      print(
          '📊 LocalProfileRepository: Calculating statistics for user $userId');

      // Get symptom entries count and flareup count
      final symptoms = await (_db.select(_db.symptomEntries)
            ..where((t) => t.userId.equals(userId)))
          .get();

      int totalSymptoms = symptoms.length;
      int flareupCount = symptoms.where((s) => s.isFlareup).length;

      // Calculate average severity (assuming severity is stored as text like "1", "2", etc.)
      double avgSeverity = 0.0;
      if (totalSymptoms > 0) {
        double totalSeverity = 0.0;
        int validSeverityCount = 0;

        for (final symptom in symptoms) {
          final severityValue = _convertSeverityToNumber(symptom.severity);
          if (severityValue > 0) {
            totalSeverity += severityValue;
            validSeverityCount++;
          }
        }

        avgSeverity =
            validSeverityCount > 0 ? totalSeverity / validSeverityCount : 0.0;
      }

      // Get photo count
      final photos = await (_db.select(_db.photos)
            ..where((t) => t.userId.equals(userId)))
          .get();
      int photoCount = photos.length;

      // Get active reminders count - filter after query for simplicity
      final allReminders = await (_db.select(_db.reminders)
            ..where((t) => t.userId.equals(userId)))
          .get();
      int activeRemindersCount = allReminders.where((r) => r.isActive).length;

      // Get medications count (assuming all medications in local DB are active)
      final medications = await (_db.select(_db.medications)
            ..where((t) => t.userId.equals(userId)))
          .get();
      int activeMedicationsCount = medications.length;

      final stats = {
        'totalSymptoms': totalSymptoms,
        'flareupCount': flareupCount,
        'averageSeverity': avgSeverity,
        'photoCount': photoCount,
        'activeReminders': activeRemindersCount,
        'activeMedications': activeMedicationsCount,
      };

      print('✅ LocalProfileRepository: Statistics calculated: $stats');
      return stats;
    } catch (e) {
      print('❌ LocalProfileRepository: Error calculating statistics: $e');
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

  // Debug: Update profile in local database
  Future<bool> updateProfile(ProfileModel profile) async {
    try {
      print('💾 LocalProfileRepository: Updating profile ${profile.id}');

      await (_db.update(_db.profiles)..where((t) => t.id.equals(profile.id)))
          .write(ProfilesCompanion(
        firstName: Value(profile.firstName ?? ''),
        lastName: Value(profile.lastName ?? ''),
        displayName: Value(profile.displayName ?? ''),
        dateOfBirth: Value(profile.dateOfBirth ?? DateTime.now()),
        knownAllergies: Value(jsonEncode(profile.knownAllergies ?? [])),
        medicalNotes: Value(profile.medicalNotes ?? ''),
        updatedAt: Value(DateTime.now()),
      ));

      print('✅ LocalProfileRepository: Profile updated successfully');
      return true;
    } catch (e) {
      print('❌ LocalProfileRepository: Error updating profile: $e');
      return false;
    }
  }

  // Debug: Convert local profile data to ProfileModel format
  Map<String, dynamic> _convertProfileToMap(Profile profile) {
    return {
      'id': profile.id,
      'email': profile.email,
      'first_name': profile.firstName,
      'last_name': profile.lastName,
      'display_name': profile.displayName,
      'avatar_url': profile.avatarUrl,
      'date_of_birth': profile.dateOfBirth.toIso8601String(),
      'known_allergies': profile.knownAllergies.isNotEmpty
          ? jsonDecode(profile.knownAllergies)
          : <String>[],
      'medical_notes': profile.medicalNotes,
      'created_at': profile.createdAt.toIso8601String(),
      'updated_at': profile.updatedAt.toIso8601String(),
    };
  }

  // Debug: Convert severity text to numeric value
  double _convertSeverityToNumber(String severity) {
    // Try to parse as number first
    final numValue = double.tryParse(severity);
    if (numValue != null) return numValue;

    // Handle text-based severity levels
    switch (severity.toLowerCase()) {
      case 'mild':
      case 'low':
        return 1.0;
      case 'moderate':
      case 'medium':
        return 2.0;
      case 'severe':
      case 'high':
        return 3.0;
      case 'extreme':
        return 4.0;
      default:
        return 0.0;
    }
  }
}
