import 'package:flutter/material.dart';

void showSymptomWindow(BuildContext context) {
  DateTime selectedDate = DateTime.now();
  DateTime focusedDate = DateTime.now();

  final TextEditingController descriptionController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext bottomSheetContext) {
      final height = MediaQuery.of(bottomSheetContext).size.height;

      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(
              top: 24,
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  const Text(
                    'Date',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),

                  const SizedBox(height: 24),

                  const Text(
                    'Symptom Description',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),

                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Describe your symptom',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 32),

                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Save logic here
                        Navigator.pop(context);
                      },
                      child: const Text('Save Symptom Log'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
