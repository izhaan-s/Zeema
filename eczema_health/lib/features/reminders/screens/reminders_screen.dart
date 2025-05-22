import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../navigation/app_router.dart';
import '../controllers/reminder_controller.dart';
import '../../../data/models/reminder_model.dart';
import '../widgets/reminder_section_card.dart';
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
  }

  String frequencyLabel(ReminderModel reminder) {
    final days = reminder.repeatDays;
    final activeDays =
        days.where((d) => d == 'true' || (d is bool && d == true)).length;
    if (activeDays == 7) {
      return 'Daily';
    } else if (activeDays == 1) {
      return 'Weekly';
    } else {
      return 'Custom';
    }
  }

  Map<String, List<ReminderModel>> groupByFrequency(
      List<ReminderModel> reminders) {
    final Map<String, List<ReminderModel>> grouped = {
      'Daily': [],
      'Weekly': [],
      'Custom': [],
    };
    for (final reminder in reminders) {
      final label = frequencyLabel(reminder);
      grouped[label]!.add(reminder);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _controller,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          title: Text('Reminders',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  )),
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ElevatedButton.icon(
                onPressed: () async {
                  await Navigator.pushNamed(context, AppRouter.addReminder);
                  // Refresh reminders after returning
                  setState(() {});
                },
                icon: const Icon(Icons.add, size: 18, color: Colors.white),
                label: const Text('Add'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3b82f6),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Consumer<ReminderController>(
                builder: (context, controller, child) {
                  if (controller.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (controller.reminders.isEmpty) {
                    return const EmptyRemindersView();
                  }
                  final grouped = groupByFrequency(controller.reminders);
                  return ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      if (grouped['Daily']!.isNotEmpty)
                        ReminderSectionCard(
                          title: 'Daily',
                          reminders: grouped['Daily']!,
                          color: Colors.blue,
                          backgroundColor: Colors.white,
                        ),
                      if (grouped['Weekly']!.isNotEmpty)
                        ReminderSectionCard(
                          title: 'Weekly',
                          reminders: grouped['Weekly']!,
                          color: Colors.green,
                          backgroundColor: Colors.white,
                        ),
                      if (grouped['Custom']!.isNotEmpty)
                        ReminderSectionCard(
                          title: 'Custom',
                          reminders: grouped['Custom']!,
                          color: Colors.purple,
                          backgroundColor: Colors.white,
                        ),
                    ],
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
