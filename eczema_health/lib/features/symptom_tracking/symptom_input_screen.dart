import 'package:eczema_health/data/app_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/models/symptom_entry_model.dart';
import '../../data/repositories/local/symptom_repository.dart';
import 'widgets/medication_selection_dialog.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:eczema_health/data/services/sync_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SymptomInputScreen extends StatefulWidget {
  final SymptomEntryModel? symptom;

  const SymptomInputScreen({super.key, this.symptom});

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
    _initializeFormData();
  }

  void _initializeFormData() {
    if (widget.symptom != null) {
      final symptom = widget.symptom!;
      selectedDate = symptom.date;
      intensity = double.tryParse(symptom.severity) ?? 1.0;

      if (symptom.symptoms != null) {
        selectedSymptoms.addAll(symptom.symptoms!);
      }

      if (symptom.medications != null) {
        selectedMedications.addAll(symptom.medications!);
      }

      if (symptom.notes != null && symptom.notes!.isNotEmpty) {
        notesController.text = symptom.notes!.first;
      }
    }
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

  Future<void> _selectDateCupertino(BuildContext context) async {
    DateTime tempPicked = selectedDate;
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.only(top: 16, bottom: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: selectedDate,
                  minimumDate: DateTime(2020),
                  maximumDate: DateTime(2100),
                  onDateTimeChanged: (DateTime newDate) {
                    tempPicked = newDate;
                  },
                ),
              ),
              const SizedBox(height: 8),
              CupertinoButton.filled(
                child: const Text('Done'),
                onPressed: () {
                  setState(() => selectedDate = tempPicked);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
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
        userId: Supabase.instance.client.auth.currentUser?.id ?? "",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title:
              Text(widget.symptom != null ? 'Edit Symptoms' : 'Log Symptoms'),
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
                final symptomRepository =
                    Provider.of<LocalSymptomRepository>(context, listen: false);
                final syncService =
                    Provider.of<SyncService>(context, listen: false);

                try {
                  if (widget.symptom != null) {
                    // Update existing entry
                    final updatedEntry = SymptomEntryModel(
                        id: widget.symptom!.id,
                        userId: widget.symptom!.userId,
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
                        createdAt: widget.symptom!.createdAt,
                        updatedAt: DateTime.now());

                    await symptomRepository.updateSymptomEntry(updatedEntry);
                  } else {
                    // Create new entry
                    final entry = SymptomEntryModel(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        userId:
                            Supabase.instance.client.auth.currentUser?.id ?? "",
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

                    await symptomRepository.addSymptomEntry(entry);
                  }

                  // Increment change count and try to sync
                  await syncService.incrementChangeCount('symptom');
                  await syncService.syncData();

                  if (mounted) {
                    Navigator.pop(
                        context, true); // Return true to indicate success
                  }
                } catch (e) {
                  // Show error message
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error saving symptom entry: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
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
                const Text("Date",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: () => _selectDateCupertino(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(CupertinoIcons.calendar,
                            size: 20, color: CupertinoColors.activeBlue),
                        const SizedBox(width: 12),
                        Text(
                          DateFormat.yMMMMd().format(selectedDate),
                          style: const TextStyle(fontSize: 16),
                        ),
                        const Spacer(),
                        const Icon(CupertinoIcons.chevron_down,
                            size: 18, color: CupertinoColors.systemGrey),
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
      ),
    );
  }
}
