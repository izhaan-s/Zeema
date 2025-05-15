import 'package:flutter/material.dart';
import '../../../data/models/reminder_model.dart';
import 'package:intl/intl.dart';

class ReminderCard extends StatelessWidget {
  final ReminderModel reminder;
  final VoidCallback onDelete;
  final Function(bool) onToggleStatus;

  const ReminderCard({
    super.key,
    required this.reminder,
    required this.onDelete,
    required this.onToggleStatus,
  });

  String _formatTime(DateTime dateTime) {
    return DateFormat.jm().format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Dismissible(
        key: Key(reminder.id),
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 16),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (_) => onDelete(),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          title: Text(
            reminder.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 16, color: Colors.blue),
                  const SizedBox(width: 8),
                  Text(
                    _formatTime(reminder.dateTime),
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              if (reminder.description != null &&
                  reminder.description!.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  reminder.description!,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ],
          ),
          trailing: Switch(
            value: reminder.isActive,
            onChanged: onToggleStatus,
          ),
        ),
      ),
    );
  }
}
