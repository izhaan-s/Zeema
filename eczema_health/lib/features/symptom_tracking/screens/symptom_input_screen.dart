import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  final TextEditingController notesController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              // TODO: Submit logic
              Navigator.pop(context);
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
