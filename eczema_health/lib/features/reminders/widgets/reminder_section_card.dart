import 'package:flutter/material.dart';
import '../../../data/models/reminder_model.dart';
import 'custom_reminder_card.dart';

class ReminderSectionCard extends StatelessWidget {
  final String title;
  final List<ReminderModel> reminders;
  final Color color;

  const ReminderSectionCard({
    super.key,
    required this.title,
    required this.reminders,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (reminders.isEmpty) return const SizedBox.shrink();
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 1,
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    )),
            const SizedBox(height: 12),
            ...reminders
                .map((reminder) =>
                    CustomReminderCard(reminder: reminder, color: color))
                .toList(),
          ],
        ),
      ),
    );
  }
}
