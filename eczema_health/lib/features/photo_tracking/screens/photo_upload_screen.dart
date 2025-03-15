import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/repositories/photo_repository.dart';

class PhotoUploadScreen extends StatefulWidget {
  const PhotoUploadScreen({super.key});

  @override
  State<PhotoUploadScreen> createState() => _PhotoUploadScreenState();
}

class _PhotoUploadScreenState extends State<PhotoUploadScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  bool _isLoading = false;
  String? _selectedBodyPart;
  final _notesController = TextEditingController();

  final List<String> bodyParts = [
    'Face',
    'Neck',
    'Chest',
    'Back',
    'Arms',
    'Legs',
    'Hands',
    'Feet',
    'Other',
  ];

  Future<void> _pickImage(ImageSource source) async{
    try {
      setState(() => _isLoading = true);
      final XFile? image = await _picker.pickImage(source: source, imageQuality: 80);

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
          _isLoading = false;
        });
      }
    } catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to pick image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}