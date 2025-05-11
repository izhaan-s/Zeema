import 'package:flutter/material.dart';

class NotesInput extends StatelessWidget {
  final TextEditingController controller;

  const NotesInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: "Notes (optional)",
        border: OutlineInputBorder(),
      ),
      maxLines: 2,
    );
  }
}
