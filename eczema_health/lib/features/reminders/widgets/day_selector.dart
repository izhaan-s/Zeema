import 'package:flutter/material.dart';

class DaySelector extends StatelessWidget {
  final List<bool> selectedDays;
  final Function(int) onDaySelected;
  final List<String> daysOfWeek;

  const DaySelector({
    super.key,
    required this.selectedDays,
    required this.onDaySelected,
    this.daysOfWeek = const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Repeat on:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: daysOfWeek.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: FilterChip(
                  label: Text(daysOfWeek[index]),
                  selected: selectedDays[index],
                  onSelected: (selected) => onDaySelected(index),
                  selectedColor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  checkmarkColor: Theme.of(context).colorScheme.primary,
                  labelStyle: TextStyle(
                    color: selectedDays[index]
                        ? Theme.of(context).colorScheme.primary
                        : Colors.black,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
