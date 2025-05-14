import 'package:flutter/material.dart';
import '../../../navigation/app_router.dart';
import '../widgets/album_list_item.dart';
import '../widgets/photo_grid_item.dart';

class PhotoGalleryScreen extends StatefulWidget {
  const PhotoGalleryScreen({super.key});

  @override
  State<PhotoGalleryScreen> createState() => _PhotoGalleryScreenState();
}

class _PhotoGalleryScreenState extends State<PhotoGalleryScreen> {
  final List<Map<String, String>> _photos = List.generate(
    12,
    (i) => {
      'image': 'assets/images/placeholder.png',
      'date': '2024-06-${(i % 30 + 1).toString().padLeft(2, '0')}',
      'bodyPart': ['Face', 'Arms', 'Legs', 'Hands', 'Feet'][i % 5],
    },
  );

  @override
  Widget build(BuildContext context) {
    final Map<String, List<Map<String, String>>> albums = {};
    for (var photo in _photos) {
      final part = photo['bodyPart'] ?? 'Other';
      albums.putIfAbsent(part, () => []).add(photo);
    }
    final albumKeys = albums.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Albums',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRouter.photoUpload);
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add_a_photo, color: Colors.white),
      ),
      body: _photos.isEmpty
          ? _buildEmptyPlaceholder()
          : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: albums.length + 1, // +1 for "All Photos"
              separatorBuilder: (_, __) => const SizedBox(height: 18),
              itemBuilder: (context, index) {
                if (index == 0) {
                  // "All Photos" item
                  return AlbumListItem(
                    albumName: 'All Photos',
                    coverPhotoUrl: _photos.isNotEmpty
                        ? _photos.first['image']!
                        : 'assets/images/placeholder.png',
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
                final coverPhoto = photosInAlbum.first;
                return AlbumListItem(
                  albumName: bodyPart,
                  coverPhotoUrl: coverPhoto['image']!,
                  photoCount: photosInAlbum.length,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AlbumGridView(
                          albumName: bodyPart,
                          photos: photosInAlbum,
                        ),
                      ),
                    );
                  },
                );
              },
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
  final String heroTag; // Added heroTag
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
            child: Image.asset(
              photo['image']!,
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
