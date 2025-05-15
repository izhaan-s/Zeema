import 'package:flutter/material.dart';
import '../../../data/models/reminder_model.dart';
import 'package:intl/intl.dart';

class CustomReminderCard extends StatelessWidget {
  final ReminderModel reminder;
  final Color color;

  static const List<String> daysOfWeek = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];

  const CustomReminderCard(
      {super.key, required this.reminder, required this.color});

  String get repeatText {
    final days = reminder.repeatDays;
    final activeDays = days.where((d) => d == 'true' || d == true).length;
    if (activeDays == 7) {
      return 'Daily';
    } else if (activeDays == 1) {
      int idx = days.indexWhere((d) => d == 'true' || d == true);
      if (idx != -1) {
        return daysOfWeek[idx];
      } else {
        return 'Weekly';
      }
    } else {
      // Custom: show which days
      List<String> selected = [];
      for (int i = 0; i < days.length; i++) {
        if (days[i] == 'true' || days[i] == true) {
          selected.add(daysOfWeek[i]);
        }
      }
      return selected.join(', ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 48,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
            margin: const EdgeInsets.only(right: 12, top: 4),
          ),
          Icon(
            reminder.isActive
                ? Icons.notifications_active
                : Icons.notifications_off,
            color: color,
            size: 22,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reminder.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: reminder.isActive ? Colors.black : Colors.grey,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${DateFormat.jm().format(reminder.dateTime)} • $repeatText',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
