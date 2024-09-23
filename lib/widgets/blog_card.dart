import 'package:flutter/material.dart';
import 'package:somnio_flutter_challenge/widgets/somnio_network_image.dart';

const mockImageUrl =
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQnYJUVD-6uVGm3dLEVbCf0BwHckzZ4_pOF1w&s';

/// {@template blog_card}
/// A custom card widget that displays a blog post, including the title,
/// description, a label, an image, and favorite/read more actions.
///
/// [title] is the blog title, [description] is a short description of the blog,
/// and [imageUrl] is the blog image's URL.
/// {@endtemplate}
class BlogCard extends StatelessWidget {
  /// {@macro blog_card}
  const BlogCard({
    super.key,
    required this.title,
    required this.description,
    this.label = 'Community',
    this.isFavorite = false,
    this.onFavoriteTap,
    this.onTap,
    this.imageUrl,
  });

  /// The title of the blog post.
  final String title;

  /// The description of the blog post.
  final String description;

  /// The label shown on the chip (default: 'Community').
  final String label;

  /// Whether the blog is marked as favorite (default: false).
  final bool isFavorite;

  /// Called when the favorite icon is tapped.
  final VoidCallback? onFavoriteTap;

  /// Called when the card is tapped (e.g., for 'Read more').
  final VoidCallback? onTap;

  /// The URL of the blog image.
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  backgroundColor: Theme.of(context).primaryColor,
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  label: Text(label),
                ),
                GestureDetector(
                  onTap: () {
                    onFavoriteTap?.call();
                  },
                  child: Icon(
                    isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: onTap,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Read more',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward,
                    size: 12,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SomnioNetworkImage(
              photoUrl: imageUrl ?? mockImageUrl,
              width: MediaQuery.of(context).size.width,
              height: 120,
              radius: 16,
            ),
          ],
        ),
      ),
    );
  }
}
