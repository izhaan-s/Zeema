import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import '../../../navigation/app_router.dart';

class PhotoGalleryScreen extends StatefulWidget {
  const PhotoGalleryScreen({super.key});

  @override
  State<PhotoGalleryScreen> createState() => _PhotoGalleryScreenState();
}

class _PhotoGalleryScreenState extends State<PhotoGalleryScreen> {
  final List<String> _bodyParts = [
    'All',
    'Face',
    'Neck',
    'Arms',
    'Legs',
    'Hands',
    'Feet',
    'Back',
    'Chest',
    'Other'
  ];

  String _selectedBodyPart = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Gallery'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              setState(() {
                _selectedBodyPart = value;
              });
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRouter.photoUpload);
        },
        child: const Icon(Icons.add_a_photo),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                '$_selectedBodyPart Photos',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.8,
                    ), 
                  itemCount: 9, // Replace with actual photo count
                  itemBuilder: (context, index) {
                    return Image.asset('assets/images/placeholder.png');
                  }
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
