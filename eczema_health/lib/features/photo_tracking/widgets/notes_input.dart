import 'package:flutter/material.dart';

class NotesInput extends StatelessWidget {
  final TextEditingController controller;

  const NotesInput({Key? key, required this.controller}) : super(key: key);

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
