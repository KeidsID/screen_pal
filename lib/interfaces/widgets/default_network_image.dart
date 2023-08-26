import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DefaultNetworkImage extends StatelessWidget {
  /// Create [CachedNetworkImage] with default configs.
  const DefaultNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit,
  });

  final String imageUrl;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: fit,
      imageUrl: imageUrl,
      placeholder: (_, __) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (_, __, ___) => const Center(
        child: Icon(Icons.broken_image_outlined, size: 16.0),
      ),
    );
  }
}
