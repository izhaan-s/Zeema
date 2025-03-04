import 'package:flutter/material.dart';

void main() {
  runApp(const EczemaHealthApp());
}

class EczemaHealthApp extends StatelessWidget {
  const EczemaHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eczema Health',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Text('Eczema Health App'),
        ),
      ),
    );
  }
}