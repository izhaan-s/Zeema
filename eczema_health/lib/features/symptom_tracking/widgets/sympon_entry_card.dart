import 'package:eczema_health/data/models/symptom_entry_model.dart';
import 'package:flutter/material.dart';

class SymptomEntryCard extends StatelessWidget {
  final SymptomEntryModel symptom;
  const SymptomEntryCard({super.key, required this.symptom});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 1,
      color: Colors.white.withOpacity(0.98),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.withOpacity(0.08), width: 0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              symptom.date.toLocal().toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF424242),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              symptom.severity,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF424242),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
