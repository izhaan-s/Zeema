import 'package:eczema_health/data/models/symptom_entry_model.dart';
import 'package:eczema_health/features/symptom_tracking/widgets/symptom_entry_card.dart';
import 'package:flutter/material.dart';

class SymptomEntries extends StatefulWidget {
  const SymptomEntries({super.key, required this.symptoms});
  final List<SymptomEntryModel> symptoms;

  @override
  State<SymptomEntries> createState() => _SymptomEntriesState();
}

class _SymptomEntriesState extends State<SymptomEntries> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.symptoms.length,
      itemBuilder: (context, index) {
        return SymptomEntryCard(symptom: widget.symptoms[index]);
      },
    );
  }
}
