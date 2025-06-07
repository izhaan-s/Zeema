import 'package:eczema_health/features/symptom_tracking/symptom_input_screen.dart';
import 'package:flutter/material.dart';
import 'widgets/symptom_calendar.dart';
import 'package:eczema_health/data/repositories/local/symptom_repository.dart';
import 'package:eczema_health/data/app_database.dart';
import 'package:eczema_health/data/models/symptom_entry_model.dart';
import 'widgets/sympom_entries.dart' as symptom_widgets;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:eczema_health/data/services/sync_service.dart';

class SymptomTrackingScreen extends StatefulWidget {
  const SymptomTrackingScreen({super.key});

  @override
  State<SymptomTrackingScreen> createState() => _SymptomTrackingScreenState();
}

class _SymptomTrackingScreenState extends State<SymptomTrackingScreen> {
  late final LocalSymptomRepository _symptomRepository;
  late final SyncService _syncService;
  final String userId = Supabase.instance.client.auth.currentUser?.id ?? "";
  List<SymptomEntryModel> _symptoms = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initDependencies();
  }

  Future<void> _initDependencies() async {
    final db = await DBProvider.instance.database;
    _symptomRepository = LocalSymptomRepository(db);
    _syncService = SyncService(db);
    await _loadSymptoms();
  }

  Future<void> _loadSymptoms() async {
    try {
      // Try to sync data first
      await _syncService.syncData();

      // Then load local symptoms
      final symptoms = await _symptomRepository.getSymptomEntries(userId);
      setState(() {
        _symptoms = symptoms;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading symptoms: $e');
      // If sync fails, still try to load local data
      final symptoms = await _symptomRepository.getSymptomEntries(userId);
      setState(() {
        _symptoms = symptoms;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Symptom Tracking',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                )),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF3b82f6),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SymptomInputScreen(),
                  ),
                );
                // Refresh symptoms after returning
                await _loadSymptoms();
              },
              icon: const Icon(Icons.add, size: 18, color: Colors.white),
              label: const Text('Log Symptoms'),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SymptomCalendar(
            symptoms: _symptoms,
            onDateSelected: (date) {},
          ),
          const SizedBox(height: 8),
          const Text(
            'Recent Symptoms Entries',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: symptom_widgets.SymptomEntries(symptoms: _symptoms),
          ),
        ],
      ),
    );
  }
}
