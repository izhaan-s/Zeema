import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../data/local/app_database.dart';
import '../../../data/repositories/local_storage/medication_repository.dart';

class MedicationSelectionDialog extends StatefulWidget {
  final Set<String> selectedMedications;
  final Function(Set<String>) onMedicationsSelected;
  final String userId;

  const MedicationSelectionDialog({
    super.key,
    required this.selectedMedications,
    required this.onMedicationsSelected,
    required this.userId,
  });

  @override
  State<MedicationSelectionDialog> createState() =>
      _MedicationSelectionDialogState();
}

class _MedicationSelectionDialogState extends State<MedicationSelectionDialog> {
  List<Map<String, dynamic>> preloadedMedications = [];
  List<Map<String, dynamic>> userMedications = [];
  bool showPreloadedMeds = true;
  bool showOnlyUserMeds = false;
  late Set<String> tempSelectedMedications;
  String searchQuery = '';
  String selectedCategory = 'All';
  late LocalMedicationRepository _medicationRepository;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    tempSelectedMedications = Set.from(widget.selectedMedications);
    _initRepository();
  }

  Future<void> _initRepository() async {
    final db = await DBProvider.instance.database;
    _medicationRepository = LocalMedicationRepository(db);
    setState(() {
      _isInitialized = true;
    });
    _loadPreloadedMedications();
    _loadUserMedications();
  }

  Future<void> _loadPreloadedMedications() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/preloaded_medications.json');
      final List<dynamic> medications = json.decode(jsonString);
      setState(() {
        preloadedMedications =
            medications.map((med) => med as Map<String, dynamic>).toList();
      });
    } catch (e) {
      print('Error loading preloaded medications: $e');
    }
  }

  Future<void> _loadUserMedications() async {
    if (!_isInitialized) return;

    try {
      final medications =
          await _medicationRepository.getUserMedications(widget.userId);
      setState(() {
        userMedications = medications.map((med) => med.toJson()).toList();
      });
    } catch (e) {
      print('Error loading user medications: $e');
    }
  }

  List<Map<String, dynamic>> get filteredMedications {
    List<Map<String, dynamic>> medications =
        showOnlyUserMeds ? userMedications : preloadedMedications;

    // Apply search filter
    if (searchQuery.isNotEmpty) {
      medications = medications.where((med) {
        final name = med['name'].toString().toLowerCase();
        final dosage = med['dosage']?.toString().toLowerCase() ?? '';
        final query = searchQuery.toLowerCase();
        return name.contains(query) || dosage.contains(query);
      }).toList();
    }

    // Apply category filter
    if (selectedCategory != 'All') {
      medications = medications.where((med) {
        if (selectedCategory == 'Steroids') {
          return med['isSteroid'] == true;
        } else if (selectedCategory == 'Non-Steroids') {
          return med['isSteroid'] == false;
        }
        return true;
      }).toList();
    }

    return medications;
  }

  Widget _buildMedicationChip(Map<String, dynamic> medication) {
    final isSelected = tempSelectedMedications.contains(medication['id']);
    return Tooltip(
      message:
          '${medication['dosage'] ?? 'No dosage'} - ${medication['frequency'] ?? 'No frequency'}',
      child: ChoiceChip(
        label: Text(medication['name']),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            if (selected) {
              tempSelectedMedications.add(medication['id']);
            } else {
              tempSelectedMedications.remove(medication['id']);
            }
          });
        },
        selectedColor: Colors.blue.shade100,
        backgroundColor: Colors.grey.shade100,
        labelStyle: TextStyle(
          color: isSelected ? Colors.blue.shade700 : Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Select Medications",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Search bar
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search medications...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
            const SizedBox(height: 16),
            // Category filter
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  'All',
                  'Steroids',
                  'Non-Steroids',
                ].map((category) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(category),
                      selected: selectedCategory == category,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            selectedCategory = category;
                          });
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            // Filter options
            Row(
              children: [
                Checkbox(
                  value: showPreloadedMeds,
                  onChanged: (value) {
                    setState(() {
                      showPreloadedMeds = value ?? true;
                    });
                  },
                ),
                const Text("Show preloaded medications"),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: showOnlyUserMeds,
                  onChanged: (value) {
                    setState(() {
                      showOnlyUserMeds = value ?? false;
                    });
                  },
                ),
                const Text("Only show my medications"),
              ],
            ),
            const SizedBox(height: 16),
            // Add medication button
            if (showOnlyUserMeds)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text("Add New Medication"),
                ),
              ),
            // Medication list
            if (showPreloadedMeds || showOnlyUserMeds)
              Flexible(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        filteredMedications.map(_buildMedicationChip).toList(),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    widget.onMedicationsSelected(tempSelectedMedications);
                    Navigator.pop(context);
                  },
                  child: const Text("Done"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
