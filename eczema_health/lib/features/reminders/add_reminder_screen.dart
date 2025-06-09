import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'reminder_controller.dart';
import 'widgets/day_selector.dart';
import '../../data/models/reminder_model.dart';

class AddReminderScreen extends StatefulWidget {
  final ReminderModel? reminder; // null for create, non-null for edit

  const AddReminderScreen({super.key, this.reminder});

  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _dosageController;
  late TextEditingController _notesController;
  late TimeOfDay _selectedTime;
  late List<bool> _selectedDays;
  bool _isLoading = false;

  bool get isEditing => widget.reminder != null;

  @override
  void initState() {
    super.initState();

    if (isEditing) {
      // Initialize with existing reminder data
      _titleController = TextEditingController(text: widget.reminder!.title);
      _dosageController =
          TextEditingController(text: widget.reminder!.description ?? '');
      _notesController =
          TextEditingController(text: widget.reminder!.description ?? '');
      _selectedTime = TimeOfDay.fromDateTime(widget.reminder!.dateTime);
      _selectedDays =
          widget.reminder!.repeatDays.map((day) => day == 'true').toList();

      // Ensure we have 7 days
      while (_selectedDays.length < 7) {
        _selectedDays.add(false);
      }
    } else {
      // Initialize with empty data for new reminder
      _titleController = TextEditingController();
      _dosageController = TextEditingController();
      _notesController = TextEditingController();
      _selectedTime = TimeOfDay.now();
      _selectedDays = List.generate(7, (_) => false);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _dosageController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  Future<void> _saveReminder() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (!_selectedDays.contains(true)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select at least one day of the week'),
          ),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      try {
        final controller = context.read<ReminderController>();

        if (isEditing) {
          // Update existing reminder
          print(
              'AddReminderScreen: Editing mode - calling updateReminder with id: ${widget.reminder!.id}');
          await controller.updateReminder(
            id: widget.reminder!.id,
            title: _titleController.text,
            description:
                _notesController.text.isNotEmpty ? _notesController.text : null,
            time: _selectedTime,
            repeatDays: _selectedDays,
          );
        } else {
          // Create new reminder
          print('AddReminderScreen: Creating new reminder');
          await controller.createReminder(
            title: _titleController.text,
            description:
                _notesController.text.isNotEmpty ? _notesController.text : null,
            time: _selectedTime,
            repeatDays: _selectedDays,
            dosage: _dosageController.text.isNotEmpty
                ? _dosageController.text
                : null,
          );
        }

        if (mounted) {
          // Show success snackbar before popping
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(isEditing
                  ? 'Reminder updated successfully'
                  : 'Reminder created successfully'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
          Navigator.pop(context, true); // Return true to indicate success
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'Failed to ${isEditing ? 'update' : 'save'} reminder: ${e.toString()}')),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            isEditing ? 'Edit Reminder' : 'Add Reminder',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            TextButton(
              onPressed: _isLoading ? null : _saveReminder,
              child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    )
                  : Text(
                      isEditing ? 'Update' : 'Save',
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
            ),
            const SizedBox(width: 16),
          ],
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Medication name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.medication),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter medication name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _dosageController,
                decoration: const InputDecoration(
                  labelText: 'Dosage',
                  hintText: 'e.g., 1 pill, 10ml, etc.',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.medical_information),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _selectTime,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.access_time, color: Colors.grey),
                      const SizedBox(width: 10),
                      Text(
                        _selectedTime.format(context),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_drop_down, color: Colors.grey),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              DaySelector(
                selectedDays: _selectedDays,
                onDaySelected: (index) {
                  setState(() {
                    _selectedDays[index] = !_selectedDays[index];
                  });
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Notes (Optional)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.note),
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
