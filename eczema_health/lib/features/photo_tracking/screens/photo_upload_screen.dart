import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/repositories/cloud/photo_repository.dart';
import '../widgets/body_part_selector.dart';
import '../widgets/image_picker_section.dart';
import '../widgets/notes_input.dart';

class PhotoUploadScreen extends StatefulWidget {
  const PhotoUploadScreen({super.key});

  @override
  State<PhotoUploadScreen> createState() => _PhotoUploadScreenState();
}

class _PhotoUploadScreenState extends State<PhotoUploadScreen> {
  final ImagePicker _picker = ImagePicker();
  late final PhotoRepository photoRepository;
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

  Future<void> _pickImage(ImageSource source) async {
    try {
      setState(() => _isLoading = true);
      final XFile? image =
          await _picker.pickImage(source: source, imageQuality: 80);

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
          _isLoading = false;
        });
      }
    } catch (e) {
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
    return Scaffold(
      appBar: AppBar(
        // Add action button when image is selected
        actions: [
          if (_selectedImage != null)
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                photoRepository = PhotoRepository();
                photoRepository.uploadPhoto(
                  photoFile: _selectedImage!,
                  bodyPart: "test data replace later",
                  itchIntensity: 2,
                  notes: ["test data replace later"],
                );
                print('Ready to upload: ${_selectedImage?.path}');
              },
            ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BodyPartSelector(
              selectedBodyPart: _selectedBodyPart,
              onSelected: (bodyPart) =>
                  setState(() => _selectedBodyPart = bodyPart),
            ),
            const SizedBox(height: 20),
            ImagePickerSection(
              selectedImage: _selectedImage,
              isLoading: _isLoading,
              onPickGallery: () => _pickImage(ImageSource.gallery),
              onPickCamera: () => _pickImage(ImageSource.camera),
            ),
            const SizedBox(height: 20),
            NotesInput(controller: _notesController),
          ],
        ),
      ),
    );
  }
}
