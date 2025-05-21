import 'package:flutter/material.dart';
import '../../../navigation/app_router.dart';
import '../widgets/album_list_item.dart';
import '../widgets/photo_grid_item.dart';
import '../../../data/repositories/local_storage/photo_repository.dart';
import '../../../data/local/app_database.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PhotoGalleryScreen extends StatefulWidget {
  const PhotoGalleryScreen({super.key});

  @override
  State<PhotoGalleryScreen> createState() => _PhotoGalleryScreenState();
}

class _PhotoGalleryScreenState extends State<PhotoGalleryScreen> {
  late PhotoRepository photoRepository;
  List<Map<String, String>> _photos = [];
  bool _isLoading = true;
  bool _useRecentPhotoAsThumbnail = true;

  // Helper method to capitalise first letter of each word
  String capitalizeBodyPart(String text) {
    if (text.isEmpty) return text;

    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences();
    _initRepository();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _useRecentPhotoAsThumbnail =
          prefs.getBool('use_recent_photo_thumbnail') ?? true;
    });
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
        'use_recent_photo_thumbnail', _useRecentPhotoAsThumbnail);
  }

  Future<void> _initRepository() async {
    photoRepository = await PhotoRepository.create();
    await _loadPhotos();
  }

  Future<void> _loadPhotos() async {
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id ?? "";
      final photos = await photoRepository.getPhotos(userId);
      setState(() {
        _photos = photos;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Get the cover photo for an album based on preference
  Map<String, String> _getCoverPhoto(List<Map<String, String>> photos) {
    if (photos.isEmpty) return {'image': 'assets/images/placeholder.png'};

    if (_useRecentPhotoAsThumbnail) {
      // Sort photos by date and get the most recent
      final sorted = List<Map<String, String>>.from(photos);
      sorted.sort((a, b) {
        final dateA = DateTime.tryParse(a['date'] ?? '') ?? DateTime(1900);
        final dateB = DateTime.tryParse(b['date'] ?? '') ?? DateTime(1900);
        return dateB.compareTo(dateA); // Most recent first
      });
      return sorted.first;
    } else {
      // Use a placeholder when toggle is off
      return {'image': 'assets/images/placeholder.png'};
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final Map<String, List<Map<String, String>>> albums = {};
    for (var photo in _photos) {
      final part = photo['bodyPart'] ?? 'Other';
      albums.putIfAbsent(part, () => []).add(photo);
    }
    final albumKeys = albums.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Gallery',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                )),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, AppRouter.photoUpload);
          // Refresh photos when returning from upload screen
          _loadPhotos();
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add_a_photo, color: Colors.white),
      ),
      body: _photos.isEmpty
          ? _buildEmptyPlaceholder()
          : Column(
              children: [
                // Toggle for recent photo as thumbnail
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10.0),
                  child: Row(
                    children: [
                      Text(
                        'Show photos on album covers',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                      const Spacer(),
                      Switch(
                        value: _useRecentPhotoAsThumbnail,
                        onChanged: (value) {
                          setState(() {
                            _useRecentPhotoAsThumbnail = value;
                          });
                          _savePreferences();
                        },
                        activeColor: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    itemCount: albums.length + 1, // +1 for "All Photos"
                    separatorBuilder: (_, __) => const SizedBox(height: 18),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        // "All Photos" item
                        final coverPhoto = _photos.isNotEmpty
                            ? _getCoverPhoto(_photos)['image']!
                            : 'assets/images/placeholder.png';

                        return AlbumListItem(
                          albumName: 'All Photos',
                          coverPhotoUrl: coverPhoto,
                          photoCount: _photos.length,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AlbumGridView(
                                  albumName: 'All Photos',
                                  photos: _photos,
                                ),
                              ),
                            );
                          },
                        );
                      }
                      // Regular album items
                      final albumIndex = index - 1;
                      final bodyPart = albumKeys[albumIndex];
                      final photosInAlbum = albums[bodyPart]!;
                      final coverPhoto = _getCoverPhoto(photosInAlbum);

                      return AlbumListItem(
                        albumName: capitalizeBodyPart(bodyPart),
                        coverPhotoUrl: coverPhoto['image']!,
                        photoCount: photosInAlbum.length,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AlbumGridView(
                                albumName: capitalizeBodyPart(bodyPart),
                                photos: photosInAlbum,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildEmptyPlaceholder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_search_rounded, size: 80, color: Colors.grey[350]),
          const SizedBox(height: 20),
          Text('No Photo Albums Yet',
              style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 20,
                  fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text(
            'Tap the + button to add your first photo!',
            style: TextStyle(color: Colors.grey[500], fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class AlbumGridView extends StatelessWidget {
  final String albumName;
  final List<Map<String, String>> photos;
  const AlbumGridView(
      {super.key, required this.albumName, required this.photos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(albumName),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: photos.isEmpty
            ? const Center(child: Text('No photos in this album.'))
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 1,
                ),
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  final photo = photos[index];
                  return PhotoGridItem(
                    photo: photo,
                    heroTagPrefix: 'album_${albumName}_photo_',
                    index: index,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => FullScreenPhotoView(
                                photo: photo,
                                heroTag:
                                    'album_${albumName}_photo_${photo["image"]}_$index')),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}

class FullScreenPhotoView extends StatelessWidget {
  final Map<String, String> photo;
  final String heroTag;
  const FullScreenPhotoView(
      {super.key, required this.photo, required this.heroTag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Hero(
            tag: heroTag,
            child: photo['image'] != null &&
                    photo['image']!.startsWith('assets')
                ? Image.asset(
                    photo['image']!,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Center(
                        child: Text('Could not load image',
                            style: TextStyle(color: Colors.white))),
                  )
                : Image.file(
                    File(photo['image']!),
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Center(
                        child: Text('Could not load image',
                            style: TextStyle(color: Colors.white))),
                  ),
          ),
        ),
      ),
    );
  }
}
