import 'package:flutter/material.dart';
import '../../../navigation/app_router.dart';
import '../../../data/repositories/cloud/reminder_repository.dart';
import '../../../data/models/reminder_model.dart';
import 'package:intl/intl.dart';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  final ReminderRepository reminderRepository = ReminderRepository();
  bool isLoading = true;
  List<ReminderModel> reminders = [];

  @override
  void initState() {
    super.initState();
    getReminders();
  }

  Future<void> getReminders() async {
    try {
      reminders = await reminderRepository.getReminders();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  String formatTime(DateTime dateTime) {
    return DateFormat.jm().format(dateTime);
  }

  Widget _buildContent() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (reminders.isEmpty) {
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

    return ListView.builder(
      itemCount: reminders.length,
      itemBuilder: (context, index) => _buildReminderItem(reminders[index]),
    );
  }

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
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
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
            padding: const EdgeInsets.all(16),
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
            child: RefreshIndicator(
              onRefresh: getReminders,
              child: _buildContent(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result =
              await Navigator.pushNamed(context, AppRouter.addReminder);
          if (result != null) {
            getReminders(); // Refresh the list when returning from add screen
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildReminderItem(ReminderModel reminder) {
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
        onDismissed: (_) async {
          try {
            // Add later
            //await reminderRepository.deleteReminder(reminder.id);
            setState(() {
              reminders.remove(reminder);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Reminder deleted')),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error deleting reminder: $e')),
            );
          }
        },
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
                    formatTime(reminder.dateTime),
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
            onChanged: (value) async {
              try {
                // Add this later
                getReminders();
              } catch (e) {
                print(e);
              }
            },
          ),
        ),
      ),
    );
  }
}
