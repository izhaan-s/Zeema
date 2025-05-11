import 'dart:io';
import 'package:flutter/material.dart';

class ImagePickerSection extends StatelessWidget {
  final File? selectedImage;
  final bool isLoading;
  final VoidCallback onPickGallery;
  final VoidCallback onPickCamera;

  const ImagePickerSection({
    super.key,
    required this.selectedImage,
    required this.isLoading,
    required this.onPickGallery,
    required this.onPickCamera,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (selectedImage != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(
              selectedImage!,
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
          ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: isLoading ? null : onPickGallery,
              icon: const Icon(Icons.photo_library),
              label: const Text('Gallery'),
            ),
            const SizedBox(width: 16),
            ElevatedButton.icon(
              onPressed: isLoading ? null : onPickCamera,
              icon: const Icon(Icons.camera_alt),
              label: const Text('Camera'),
            ),
          ],
        ),
      ],
    );
  }
}
