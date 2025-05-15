import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../navigation/app_router.dart';
import '../controllers/reminder_controller.dart';
import '../widgets/reminder_card.dart';
import '../widgets/empty_reminders_view.dart';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  late final ReminderController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ReminderController();
    _controller.loadReminders();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _controller,
      child: Scaffold(
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
                  backgroundColor: const Color(0xFF3b82f6),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
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
            const SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Set up reminders for medications and tracking.',
                style: TextStyle(
                  color: const Color(0xFF6a717d),
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Expanded(
              child: Consumer<ReminderController>(
                builder: (context, controller, child) {
                  if (controller.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.reminders.isEmpty) {
                    return const EmptyRemindersView();
                  }

                  return RefreshIndicator(
                    onRefresh: controller.loadReminders,
                    child: ListView.builder(
                      itemCount: controller.reminders.length,
                      itemBuilder: (context, index) {
                        final reminder = controller.reminders[index];
                        return ReminderCard(
                          reminder: reminder,
                          onDelete: () =>
                              controller.deleteReminder(reminder.id),
                          onToggleStatus: (value) => controller
                              .toggleReminderStatus(reminder.id, value),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
