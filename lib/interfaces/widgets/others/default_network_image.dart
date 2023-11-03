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
    this.repeat = ImageRepeat.noRepeat,
    this.fit,
    this.color,
    this.colorBlendMode,
    this.imageBuilder,
  });

  final String imageUrl;

  /// Alternative information of an image that will be displayed if the image
  /// cannot be loaded.
  final String? alt;

  /// How to paint any portions of the layout bounds not covered by the image.
  final ImageRepeat repeat;

  /// How to inscribe the image into the space allocated during layout.
  ///
  /// The default varies based on the other fields. See the discussion at
  /// [paintImage].
  final BoxFit? fit;

  /// If non-null, this color is blended with each image pixel using
  /// [colorBlendMode].
  final Color? color;

  /// Used to combine [color] with this image.
  ///
  /// The default is [BlendMode.srcIn]. In terms of the blend mode, [color] is
  /// the source and this image is the destination.
  ///
  /// See also:
  ///
  /// [BlendMode], which includes an illustration of the effect of each blend mode.
  final BlendMode? colorBlendMode;

  /// Optional builder to further customize the display of the image.
  final ImageWidgetBuilder? imageBuilder;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      repeat: repeat,
      fit: fit,
      color: color,
      colorBlendMode: colorBlendMode,
      imageBuilder: imageBuilder,
      placeholder: (_, __) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (_, __, ___) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.broken_image_outlined),
            Text(
              alt ?? '',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
