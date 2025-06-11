import 'package:supabase_flutter/supabase_flutter.dart';

class DownloadData {
  final String userId;
  final SupabaseClient _supabase = Supabase.instance.client;

  DownloadData({required this.userId});

  Future<void> _downloadSymptomEntries() async {
    try {
      final data = await _supabase
          .from('symptom_entries')
          .select('*')
          .eq('user_id', userId);
    } catch (e) {
      print('Error downloading symptom entries: $e');
    }
  }
}
