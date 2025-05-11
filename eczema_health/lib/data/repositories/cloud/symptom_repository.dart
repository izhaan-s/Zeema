import '../../models/symptom_entry_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SymptomRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> addSymptomEntry(SymptomEntryModel entry) async {
    try {
      await _supabase.from('symptom_entries').insert({
        'id': entry.id,
        'user_id': entry.userId,
        'date': entry.date.toIso8601String(),
        'is_flareup': entry.isFlareup,
        'severity': entry.severity,
        'affected_areas': entry.affectedAreas,
        'symptoms': entry.symptoms,
        'notes': entry.notes,
        'created_at': entry.createdAt.toIso8601String(),
        'updated_at': entry.updatedAt.toIso8601String(),
      });
    } catch (e) {
      throw Exception('Failed to add symptom entry: $e');
    }
  }

  Future<List<SymptomEntryModel>> getSymptomEntries() async {
    try {
      final response = await _supabase
          .from('symptom_entries')
          .select()
          .order('date', ascending: false);

      return (response as List)
          .map((entry) => SymptomEntryModel(
                id: entry['id'],
                userId: entry['user_id'],
                date: DateTime.parse(entry['date']),
                isFlareup: entry['is_flareup'],
                severity: entry['severity'],
                affectedAreas: List<String>.from(entry['affected_areas']),
                symptoms: entry['symptoms'] != null
                    ? List<String>.from(entry['symptoms'])
                    : null,
                notes: entry['notes'] != null
                    ? List<String>.from(entry['notes'])
                    : null,
                createdAt: DateTime.parse(entry['created_at']),
                updatedAt: DateTime.parse(entry['updated_at']),
              ))
          .toList();
    } catch (e) {
      throw Exception('Failed to get symptom entries: $e');
    }
  }

  Future<void> updateSymptomEntry(SymptomEntryModel entry) async {
    try {
      await _supabase.from('symptom_entries').update({
        'date': entry.date.toIso8601String(),
        'is_flareup': entry.isFlareup,
        'severity': entry.severity,
        'affected_areas': entry.affectedAreas,
        'symptoms': entry.symptoms,
        'notes': entry.notes,
        'updated_at': entry.updatedAt.toIso8601String(),
      }).eq('id', entry.id);
    } catch (e) {
      throw Exception('Failed to update symptom entry: $e');
    }
  }

  Future<void> deleteSymptomEntry(String id) async {
    try {
      await _supabase.from('symptom_entries').delete().eq('id', id);
    } catch (e) {
      throw Exception('Failed to delete symptom entry: $e');
    }
  }
}
