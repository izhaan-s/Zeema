import 'package:eczema_health/features/symptom_tracking/screens/symptom_input_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/symptom_calendar.dart';
import 'package:eczema_health/data/repositories/local_storage/symptom_repository.dart';
import 'package:eczema_health/data/local/app_database.dart';
import 'package:eczema_health/data/models/symptom_entry_model.dart';
import '../widgets/sympom_entries.dart' as symptom_widgets;

class SymptomTrackingScreen extends StatefulWidget {
  const SymptomTrackingScreen({super.key});

  @override
  State<SymptomTrackingScreen> createState() => _SymptomTrackingScreenState();
}

class _SymptomTrackingScreenState extends State<SymptomTrackingScreen> {
  late final LocalSymptomRepository _symptomRepository;
  final String userId = '1'; // TODO: Replace with actual user ID
  List<SymptomEntryModel> _symptoms = [];

  @override
  void initState() {
    super.initState();
    _symptomRepository = LocalSymptomRepository(AppDatabase());
    _loadSymptoms();
  }

  Future<void> _loadSymptoms() async {
    final symptoms = await _symptomRepository.getSymptomEntries(userId);
    setState(() {
      _symptoms = symptoms;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Symptom Tracking'),
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
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SymptomInputScreen()));
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
