import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Configured [CachedNetworkImage]. Use this instead [Image.network] or
/// [CachedNetworkImage].
class DefaultNetworkImage extends StatelessWidget {
  /// Create a [CachedNetworkImage] with configured [placeholder] and
  /// [errorWidget].
  const DefaultNetworkImage({
    super.key,
    required this.imageUrl,
    this.alt,
    this.fit,
    this.imageBuilder,
  });

  final String imageUrl;

  /// Alternative information of an image that will be displayed if the image
  /// cannot be loaded.
  final String? alt;

  /// How to inscribe the image into the space allocated during layout.
  ///
  /// The default varies based on the other fields. See the discussion at
  /// [paintImage].
  final BoxFit? fit;

  /// Optional builder to further customize the display of the image.
  final ImageWidgetBuilder? imageBuilder;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      imageBuilder: imageBuilder,
      placeholder: (_, __) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (_, __, ___) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.broken_image_outlined),
            Text(alt ?? ''),
          ],
        ),
      ),
    );
  }
}
