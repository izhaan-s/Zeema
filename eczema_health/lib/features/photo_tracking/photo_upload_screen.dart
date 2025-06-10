import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:eczema_health/data/repositories/cloud/photo_repository.dart';
import 'package:eczema_health/data/repositories/local/photo_repository.dart';
import 'package:provider/provider.dart';
import 'widgets/body_part_selector.dart';
import 'widgets/notes_input.dart';

class PhotoUploadScreen extends StatefulWidget {
  const PhotoUploadScreen({super.key});

  @override
  State<PhotoUploadScreen> createState() => _PhotoUploadScreenState();
}

class _PhotoUploadScreenState extends State<PhotoUploadScreen> {
  final ImagePicker _picker = ImagePicker();
  // late final PhotoRepository photoRepository = PhotoRepository();
  late PhotoRepository localPhotoRepository;
  File? _selectedImage;
  bool _isPickingImage = false;
  bool _isSaving = false;
  String? _selectedBodyPart;
  final _notesController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    localPhotoRepository = Provider.of<PhotoRepository>(context, listen: false);
  }

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
    if (_isPickingImage) return;
    setState(() => _isPickingImage = true);
    try {
      final XFile? image = await _picker.pickImage(
          source: source, imageQuality: 80, maxHeight: 1024, maxWidth: 1024);
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to pick image: ${e.toString()}'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isPickingImage = false);
      }
    }
  }

  void _clearImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  void _submitPhoto() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please select an image.'),
            backgroundColor: Colors.orangeAccent),
      );
      return;
    }
    if (_selectedBodyPart == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please select a body part.'),
            backgroundColor: Colors.orangeAccent),
      );
      return;
    }

    // Set saving state to show loading indicator
    setState(() {
      _isSaving = true;
    });

    try {
      final userId = Supabase.instance.client.auth.currentUser?.id ?? "";

      await localPhotoRepository.savePhoto(
        userId,
        _selectedBodyPart!,
        _selectedImage!.path,
        DateTime.now(),
        _notesController.text.isEmpty ? null : _notesController.text,
      );

      // sync to sync service

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Photo saved successfully'),
              backgroundColor: Colors.green),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to save photo: ${e.toString()}'),
              backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Photo'),
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          actions: [
            if (_selectedImage != null && _selectedBodyPart != null)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: _isSaving
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : TextButton(
                        onPressed: _submitPhoto,
                        style: TextButton.styleFrom(
                            foregroundColor:
                                Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        child: const Text('SAVE',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
              ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildImagePickerSection(),
                const SizedBox(height: 24),
                Text('Body Part',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                BodyPartSelector(
                  selectedBodyPart: _selectedBodyPart,
                  onSelected: (bodyPart) =>
                      setState(() => _selectedBodyPart = bodyPart),
                ),
                const SizedBox(height: 24),
                Text('Notes (Optional)',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                NotesInput(controller: _notesController),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePickerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Photo',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        if (_selectedImage == null)
          AspectRatio(
            aspectRatio: 16 / 10,
            child: Material(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => _pickImageDialog(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_a_photo_outlined,
                        size: 50, color: Colors.grey[600]),
                    const SizedBox(height: 8),
                    Text('Tap to select a photo',
                        style: TextStyle(color: Colors.grey[700])),
                  ],
                ),
              ),
            ),
          )
        else
          Stack(
            alignment: Alignment.topRight,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  _selectedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 250,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.black54,
                  child: IconButton(
                    icon:
                        const Icon(Icons.close, size: 16, color: Colors.white),
                    onPressed: _clearImage,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ),
              ),
            ],
          ),
        const SizedBox(height: 12),
        if (_selectedImage == null || _isPickingImage)
          _isPickingImage
              ? const Center(
                  child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: CircularProgressIndicator(),
                ))
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        icon: const Icon(Icons.photo_library_outlined),
                        label: const Text('Gallery'),
                        onPressed: () => _pickImage(ImageSource.gallery),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: FilledButton.icon(
                        icon: const Icon(Icons.camera_alt_outlined),
                        label: const Text('Camera'),
                        onPressed: () => _pickImage(ImageSource.camera),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                  ],
                ),
        if (_selectedImage != null && !_isPickingImage)
          OutlinedButton.icon(
              icon: const Icon(Icons.edit_outlined, size: 18),
              label: const Text('Change Photo'),
              onPressed: () => _pickImageDialog(),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                    color:
                        Theme.of(context).colorScheme.outline.withAlpha(128)),
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              )),
      ],
    );
  }

  void _pickImageDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(Icons.photo_library_outlined),
                  title: const Text('Photo Library'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImage(ImageSource.gallery);
                  }),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
