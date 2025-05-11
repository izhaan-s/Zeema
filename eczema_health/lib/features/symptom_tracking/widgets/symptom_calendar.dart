import 'package:flutter/material.dart';
import '../../../data/models/symptom_entry_model.dart';

class SymptomCalendar extends StatefulWidget {
  final List<SymptomEntryModel> symptoms;
  final Function(DateTime) onDateSelected;

  const SymptomCalendar(
      {super.key, required this.symptoms, required this.onDateSelected});

  @override
  State<SymptomCalendar> createState() => _SymptomCalendarState();
}

class _SymptomCalendarState extends State<SymptomCalendar> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
