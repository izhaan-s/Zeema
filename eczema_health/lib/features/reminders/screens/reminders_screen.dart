import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import '../../../navigation/app_router.dart';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reminders',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, AppRouter.addReminder);
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
                size: 18.0,
              ),
              label: const Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0, 
                  vertical: 8.0
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Text(
              'Set up reminders for medications and tracking.',
              style: TextStyle(
                color: const Color(0xFFB6BCC3),
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text('Welcome to the reminders screen'),
            ),
          ),
        ],
      ),
    );
  }
}
