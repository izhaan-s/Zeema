import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class PhotoGalleryScreen extends StatefulWidget {
  const PhotoGalleryScreen({super.key});

  @override
  State<PhotoGalleryScreen> createState() => _PhotoGalleryScreenState();
}

class _PhotoGalleryScreenState extends State<PhotoGalleryScreen> {
  final List<String> _bodyParts = [
    'All', 'Face', 'Neck', 'Arms', 'Legs', 'Hands', 'Feet', 'Back', 'Chest', 'Other'
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Gallery'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              // Add functionality to only show photos of selected body part
              print(value);
            },
            itemBuilder: (BuildContext context) {
              return _bodyParts.map((String bodyPart) {
                return PopupMenuItem<String>(
                  value: bodyPart,
                  child: Text(bodyPart),
                );
              }).toList();
            },
          ),
        ],
      ),
    );
  }
}