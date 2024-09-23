import 'package:flutter/material.dart';

class SomnioNetworkImage extends StatelessWidget {
  const SomnioNetworkImage({
    required this.photoUrl,
    super.key,
    this.radius = 8,
    this.height = 80,
    this.width = 80,
    this.fit = BoxFit.cover,
  });

  /// The URL of the image to display.
  final String photoUrl;

  /// The border radius to apply to the image.
  final double radius;

  /// The height of the image.
  final double height;

  /// The width of the image.
  final double width;

  /// How the image should be inscribed into the box.
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image(
        height: height,
        width: width,
        image: NetworkImage(photoUrl),
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      (loadingProgress.expectedTotalBytes ?? 1)
                  : null,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Icon(
              Icons.error,
              color: Colors.red,
            ),
          );
        },
      ),
    );
  }
}
