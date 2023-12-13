import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// {@template interfaces.widgets.common.common_network_image}
/// Its just [CachedNetworkImage] with defined builders.
///
/// The [placeholder] and [errorWidget] are still customizable on constructor,
/// but changed to [loadingBuilder] and [errorBuilder] instead.
/// {@endtemplate}
class CommonNetworkImage extends CachedNetworkImage {
  /// Alternative information of an image that will be displayed if the image
  /// cannot be loaded.
  ///
  /// Not used if [errorBuilder] is defined.
  final String? alt;

  /// Widget displayed while the target [imageUrl] is loading.
  final PlaceholderWidgetBuilder? loadingBuilder;

  /// Widget displayed while the target [imageUrl] failed loading.
  final LoadingErrorWidgetBuilder? errorBuilder;

  /// {@macro interfaces.widgets.common.common_network_image}
  CommonNetworkImage({
    super.key,
    required super.imageUrl,
    this.alt,
    this.loadingBuilder,
    this.errorBuilder,
    ImageWidgetBuilder? imageBuilder,
    super.httpHeaders,
    super.fadeOutDuration,
    super.fadeOutCurve,
    super.fadeInDuration,
    super.fadeInCurve,
    super.width,
    super.height,
    super.fit,
    super.alignment,
    super.repeat,
    super.matchTextDirection,
    super.cacheManager,
    super.useOldImageOnUrlChange,
    super.color,
    super.filterQuality,
    super.colorBlendMode,
    super.placeholderFadeInDuration,
    super.memCacheWidth,
    super.memCacheHeight,
    super.cacheKey,
    super.maxWidthDiskCache,
    super.maxHeightDiskCache,
    super.errorListener,
  }) : super(
          imageBuilder: imageBuilder ??
              (_, image) => Ink.image(
                    image: image,
                    fit: fit,
                    alignment: alignment,
                    repeat: repeat,
                    matchTextDirection: matchTextDirection,
                    width: width,
                    height: height,
                  ),
          placeholder: loadingBuilder ??
              (_, __) => const Center(child: CircularProgressIndicator()),
          errorWidget: errorBuilder ??
              (_, __, ___) {
                return Center(
                  child: alt == null
                      ? const Icon(Icons.broken_image_outlined)
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.broken_image_outlined),
                            Text(
                              alt,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                );
              },
        );
}
