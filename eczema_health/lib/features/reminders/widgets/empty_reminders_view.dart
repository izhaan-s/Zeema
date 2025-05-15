import 'package:flutter/material.dart';

class EmptyRemindersView extends StatelessWidget {
  const EmptyRemindersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.notifications_off,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          const Text(
            'No reminders yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Add a reminder to get started',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
