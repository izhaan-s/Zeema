import 'package:flutter/material.dart';
import '../../../data/models/reminder_model.dart';
import 'custom_reminder_card.dart';

class ReminderSectionCard extends StatelessWidget {
  final String title;
  final List<ReminderModel> reminders;
  final Color color;
  final Color? backgroundColor;
  final void Function(String id) onDelete;
  final void Function(ReminderModel reminder)? onEdit;

  const ReminderSectionCard({
    super.key,
    required this.title,
    required this.reminders,
    required this.color,
    required this.onDelete,
    this.onEdit,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    if (reminders.isEmpty) return const SizedBox.shrink();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 1,
      color: backgroundColor ?? Theme.of(context).cardColor,
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
            ...reminders.map((reminder) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Dismissible(
                    key: Key(reminder.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 16),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    onDismissed: (_) => onDelete(reminder.id),
                    child: GestureDetector(
                      onTap: onEdit != null ? () => onEdit!(reminder) : null,
                      child: CustomReminderCard(
                        reminder: reminder,
                        color: color,
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
