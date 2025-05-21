import 'package:eczema_health/data/local/app_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../data/models/symptom_entry_model.dart';
import '../../../data/repositories/local_storage/symptom_repository.dart';
import '../widgets/medication_selection_dialog.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class SymptomInputScreen extends StatefulWidget {
  const SymptomInputScreen({super.key});

  @override
  State<SymptomInputScreen> createState() => _SymptomInputScreenState();
}

class _SymptomInputScreenState extends State<SymptomInputScreen> {
  DateTime selectedDate = DateTime.now();
  double intensity = 1;
  final List<String> symptoms = [
    'Redness',
    'Itching',
    'Swelling',
    'Dryness',
    'Flaking',
    'Pain',
    'Burning',
    'Blisters',
    'Oozing',
    'Crusting'
  ];
  final Set<String> selectedSymptoms = {};
  final Set<String> selectedMedications = {};
  final TextEditingController notesController = TextEditingController();
  Map<String, String> medicationNames = {};

  @override
  void initState() {
    super.initState();
    _loadPreloadedMedications();
  }

  Future<void> _loadPreloadedMedications() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/preloaded_medications.json');

      final dynamic decodedJson = json.decode(jsonString);

      if (decodedJson is List) {
        final List<dynamic> medications = decodedJson;

        final Map<String, String> names = {};
        for (var med in medications) {
          if (med is Map) {
            if (med.containsKey('id') && med.containsKey('name')) {
              names[med['id'].toString()] = med['name'].toString();
            }
          }
        }

        setState(() {
          medicationNames = names;
        });
      }
    } catch (e) {
      // Error loading medications
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  void _showMedicationDialog() {
    showDialog(
      context: context,
      builder: (context) => MedicationSelectionDialog(
        selectedMedications: selectedMedications,
        onMedicationsSelected: (medications) {
          setState(() {
            selectedMedications.clear();
            selectedMedications.addAll(medications);
          });
        },
        userId: '1',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Symptoms'),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () async {
              final entry = SymptomEntryModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  userId: '1',
                  date: selectedDate,
                  isFlareup: intensity >= 4,
                  severity: intensity.toInt().toString(),
                  affectedAreas: selectedSymptoms.toList(),
                  symptoms: selectedSymptoms.toList(),
                  medications: selectedMedications.isNotEmpty
                      ? selectedMedications.toList()
                      : null,
                  notes: notesController.text.isNotEmpty
                      ? [notesController.text]
                      : null,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now());

              try {
                await LocalSymptomRepository(AppDatabase())
                    .addSymptomEntry(entry);
                if (mounted) {
                  Navigator.pop(context);
                }
              } catch (e) {
                // Entry save error
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Date", style: TextStyle(fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 20),
                      const SizedBox(width: 12),
                      Text(DateFormat.yMMMMd().format(selectedDate)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text("Symptom Intensity",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Slider(
                value: intensity,
                min: 1,
                max: 5,
                divisions: 4,
                label: intensity.toInt().toString(),
                onChanged: (value) {
                  setState(() => intensity = value);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Mild (1)"),
                  Text("Moderate (3)"),
                  Text("Severe (5)"),
                ],
              ),
              const SizedBox(height: 24),
              const Text("Symptoms",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: symptoms.map((symptom) {
                  final isSelected = selectedSymptoms.contains(symptom);
                  return ChoiceChip(
                    label: Text(symptom),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() {
                        if (isSelected) {
                          selectedSymptoms.remove(symptom);
                        } else {
                          selectedSymptoms.add(symptom);
                        }
                      });
                    },
                    selectedColor: Colors.blue.shade100,
                    backgroundColor: Colors.grey.shade100,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.blue.shade700 : Colors.black,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Medications",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextButton.icon(
                    onPressed: _showMedicationDialog,
                    icon: const Icon(Icons.add),
                    label: const Text("Add Medications"),
                  ),
                ],
              ),
              if (selectedMedications.isNotEmpty) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: selectedMedications.map((medicationId) {
                    return Chip(
                      label:
                          Text(medicationNames[medicationId] ?? medicationId),
                      onDeleted: () {
                        setState(() {
                          selectedMedications.remove(medicationId);
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
              const SizedBox(height: 24),
              const Text("Notes (Optional)",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextField(
                controller: notesController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText:
                      "Add any additional notes about your symptoms or potential triggers",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
