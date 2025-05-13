import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class MedicationSelectionDialog extends StatefulWidget {
  final Set<String> selectedMedications;
  final Function(Set<String>) onMedicationsSelected;

  const MedicationSelectionDialog({
    super.key,
    required this.selectedMedications,
    required this.onMedicationsSelected,
  });

  @override
  State<MedicationSelectionDialog> createState() =>
      _MedicationSelectionDialogState();
}

class _MedicationSelectionDialogState extends State<MedicationSelectionDialog> {
  List<Map<String, dynamic>> preloadedMedications = [];
  bool showPreloadedMeds = true;
  bool showOnlyUserMeds = false;
  late Set<String> tempSelectedMedications;

  @override
  void initState() {
    super.initState();
    tempSelectedMedications = Set.from(widget.selectedMedications);
    _loadPreloadedMedications();
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
            if (showPreloadedMeds && !showOnlyUserMeds)
              Flexible(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: preloadedMedications.map((medication) {
                      final isSelected =
                          tempSelectedMedications.contains(medication['id']);
                      return ChoiceChip(
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
                          color:
                              isSelected ? Colors.blue.shade700 : Colors.black,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            const SizedBox(height: 16),
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
