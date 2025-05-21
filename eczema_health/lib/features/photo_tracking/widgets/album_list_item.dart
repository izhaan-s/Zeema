import 'package:flutter/material.dart';
import 'dart:io';

class AlbumListItem extends StatelessWidget {
  final String albumName;
  final String coverPhotoUrl;
  final int photoCount;
  final VoidCallback onTap;

  const AlbumListItem({
    super.key,
    required this.albumName,
    required this.coverPhotoUrl,
    required this.photoCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.white,
        child: Row(
          children: [
            Hero(
              tag: 'album_cover_$albumName',
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 6,
                        offset: const Offset(2, 2),
                      )
                    ]),
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.horizontal(left: Radius.circular(20)),
                  child: _buildCoverImage(),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      albumName,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '$photoCount photo${photoCount > 1 ? 's' : ''}',
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant
                            .withOpacity(0.7),
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Icon(Icons.arrow_forward_ios_rounded,
                  color: Theme.of(context)
                      .colorScheme
                      .onSurfaceVariant
                      .withOpacity(0.6),
                  size: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoverImage() {
    if (coverPhotoUrl.startsWith('assets/images/placeholder.png')) {
      // Custom placeholder design
      return Container(
        width: 80,
        height: 80,
        color: Colors.grey[100],
        child: Center(
          child: Icon(
            Icons.hide_image_rounded,
            size: 36,
            color: Colors.grey[400],
          ),
        ),
      );
    } else if (coverPhotoUrl.startsWith('assets')) {
      return Image.asset(
        coverPhotoUrl,
        width: 80,
        height: 80,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
            width: 80,
            height: 80,
            color: Colors.grey[300],
            child: Icon(Icons.hide_image_outlined, color: Colors.grey[500])),
      );
    } else {
      return Image.file(
        File(coverPhotoUrl),
        width: 80,
        height: 80,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
            width: 80,
            height: 80,
            color: Colors.grey[300],
            child: Icon(Icons.hide_image_outlined, color: Colors.grey[500])),
      );
    }
  }
}
