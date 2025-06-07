import 'package:eczema_health/data/models/symptom_entry_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SymptomEntryCard extends StatelessWidget {
  final SymptomEntryModel symptom;
  const SymptomEntryCard({super.key, required this.symptom});

  Color _getSeverityColor(int severity) {
    if (severity <= 2) {
      return const Color(0xFF2ECC71); // Green
    } else if (severity == 3) {
      return const Color(0xFFFFA726); // Orange
    } else {
      return const Color(0xFFE53935); // Red
    }
  }

  Color _getSeverityBgColor(int severity) {
    if (severity <= 2) {
      return const Color(0xFFE6FAEA); // Light green
    } else if (severity == 3) {
      return const Color(0xFFFFF3E0); // Light orange
    } else {
      return const Color(0xFFFFEBEE); // Light red
    }
  }

  @override
  Widget build(BuildContext context) {
    final int severity = int.tryParse(symptom.severity) ?? 1;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200, width: 0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _getSeverityBgColor(severity),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(
                  Icons.local_fire_department,
                  color: _getSeverityColor(severity),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Main info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        DateFormat.yMMMMd().format(symptom.date),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF222B45),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    symptom.symptoms?.join(', ') ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    symptom.notes?.join(', ') ?? '',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 8, top: 2),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F0FE),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                'Intensity: ${symptom.severity}/5',
                style: const TextStyle(
                  color: Color(0xFF2563EB),
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
