import 'package:eczema_health/data/models/symptom_entry_model.dart';
import 'package:flutter/material.dart';

class SymptomMatrix extends StatelessWidget {
  final List<Map<String, double>> symptomMatrix;
  final List<SymptomEntryModel> symptoms;
  const SymptomMatrix({
    super.key,
    required this.symptomMatrix,
    required this.symptoms,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
