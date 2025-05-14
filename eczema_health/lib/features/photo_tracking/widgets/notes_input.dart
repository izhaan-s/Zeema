import 'package:flutter/material.dart';

class NotesInput extends StatelessWidget {
  final TextEditingController controller;

  const NotesInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: "Add more details about your photo...",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      ),
      maxLines: 3,
    );
  }
}
