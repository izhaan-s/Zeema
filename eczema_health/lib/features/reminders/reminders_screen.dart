import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../navigation/app_router.dart';
import 'reminder_controller.dart';
import '../../data/models/reminder_model.dart';
import 'widgets/reminder_section_card.dart';
import 'widgets/empty_reminders_view.dart';
import 'add_reminder_screen.dart';
import 'package:showcaseview/showcaseview.dart';
import '../auth/tutorial_manager.dart';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
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

  Future<void> _editReminder(ReminderModel reminder) async {
    print(
        'RemindersScreen._editReminder called for reminder: ${reminder.id}, title: ${reminder.title}');
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddReminderScreen(reminder: reminder),
      ),
    );

    // Refresh reminders after returning if reminder was updated
    if (result == true && mounted) {
      final controller = context.read<ReminderController>();
      await controller.loadReminders();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Showcase(
              key: TutorialManager.reminderKey,
              description:
                  'Tap here to set up medication reminders. Never miss a dose again!',
              child: ElevatedButton.icon(
                onPressed: () async {
                  final result =
                      await Navigator.pushNamed(context, AppRouter.addReminder);
                  // Refresh reminders after returning if reminder was created
                  if (result == true && mounted) {
                    final controller = context.read<ReminderController>();
                    await controller.loadReminders();
                  }
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
                        onEdit: _editReminder,
                        onDelete: (id) async {
                          try {
                            await controller.deleteReminder(id);
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Reminder deleted successfully'),
                                  backgroundColor: Colors.green,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          } catch (e) {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Failed to delete reminder: $e'),
                                  backgroundColor: Colors.red,
                                  duration: const Duration(seconds: 3),
                                ),
                              );
                            }
                          }
                        },
                      ),
                    if (grouped['Weekly']!.isNotEmpty)
                      ReminderSectionCard(
                        title: 'Weekly',
                        reminders: grouped['Weekly']!,
                        color: Colors.green,
                        backgroundColor: Colors.white,
                        onEdit: _editReminder,
                        onDelete: (id) async {
                          try {
                            await controller.deleteReminder(id);
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Reminder deleted successfully'),
                                  backgroundColor: Colors.green,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          } catch (e) {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Failed to delete reminder: $e'),
                                  backgroundColor: Colors.red,
                                  duration: const Duration(seconds: 3),
                                ),
                              );
                            }
                          }
                        },
                      ),
                    if (grouped['Custom']!.isNotEmpty)
                      ReminderSectionCard(
                        title: 'Custom',
                        reminders: grouped['Custom']!,
                        color: Colors.purple,
                        backgroundColor: Colors.white,
                        onEdit: _editReminder,
                        onDelete: (id) async {
                          try {
                            await controller.deleteReminder(id);
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Reminder deleted successfully'),
                                  backgroundColor: Colors.green,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          } catch (e) {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Failed to delete reminder: $e'),
                                  backgroundColor: Colors.red,
                                  duration: const Duration(seconds: 3),
                                ),
                              );
                            }
                          }
                        },
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
