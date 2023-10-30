import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' as intl;

import 'package:screen_pal/configs/constants.dart';
import 'package:screen_pal/core/entities.dart';
import 'package:screen_pal/infrastructures/api/tmdb_dio.dart';
import 'package:screen_pal/interfaces/providers/movies/movie_list_providers.dart';
import 'package:screen_pal/interfaces/providers/tv_shows/tv_show_list_providers.dart';
import 'package:screen_pal/interfaces/router/app_navigator.dart';
import 'package:screen_pal/interfaces/utils/to_ordinal.dart';
import 'package:screen_pal/interfaces/widgets.dart';

part 'sections/_main_section.dart';
part 'sections/_movie_collection_section.dart';
part 'sections/_product_recommendations_section.dart';
part 'sections/_tv_show_season_section.dart';

class ProductDetailView extends StatelessWidget {
  const ProductDetailView(this.product, {super.key});

  final ProductDetail product;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final maxW = mediaQuery.size.width;
    final maxH = mediaQuery.size.height;
    final aspectRatio = mediaQuery.size.aspectRatio;

    if (maxW >= 600) {
      if (aspectRatio >= 3 / 2 && maxW > maxH) {
        return _WideDeviceLayout(product);
      }

      return _ThinDeviceLayout(product);
    }

    return _ThinDeviceLayout(product);
  }
}

const _kScrollViewPadding = EdgeInsets.only(bottom: 16.0);

class _ThinDeviceLayout extends StatelessWidget {
  const _ThinDeviceLayout(this.product);

  final ProductDetail product;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final maxW = screenSize.width;
    final maxH = screenSize.height > 800 ? 800 : screenSize.height;
    final aspectRatio = maxW / maxH;

    final isShowPoster = aspectRatio <= 2 / 3 && maxH > maxW;

    return SingleChildScrollView(
      padding: _kScrollViewPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: maxW,
            height: (maxH * 0.8) - kToolbarHeight,
            child: DefaultNetworkImage(
              imageUrl: '$tmdbImageBaseUrl'
                  '${(isShowPoster) ? product.posterPath : product.backdropPath}',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16.0),
          _MainSection(product),
          const Padding(padding: kHorizPadding, child: Divider()),
          _MovieCollectionSection(product),
          _TvShowSeasonSection(product),
          _ProductRecommendationsSection(product),
        ],
      ),
    );
  }
}

class _WideDeviceLayout extends StatelessWidget {
  const _WideDeviceLayout(this.product);

  final ProductDetail product;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    const minH = 400.0;
    final maxH = screenSize.height > 600 ? 600 : screenSize.height;

    return SingleChildScrollView(
      padding: _kScrollViewPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // main section with bg and poster image
          SizedBox(
            height: (maxH < minH ? minH : maxH) - kToolbarHeight,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // bg image
                DefaultNetworkImage(
                  imageUrl: '$tmdbImageBaseUrl${product.backdropPath}',
                  fit: BoxFit.cover,
                  color: Colors.white.withOpacity(0.1),
                  colorBlendMode: BlendMode.modulate,
                ),

                // main section with poster image
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // poster image
                      Flexible(
                        flex: 2,
                        child: AspectRatio(
                          aspectRatio: 2 / 3,
                          child: Card(
                            child: DefaultNetworkImage(
                              imageUrl:
                                  '$tmdbImageBaseUrl${product.posterPath}',
                              alt: product.title,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                      // main section
                      Expanded(
                        flex: 3,
                        child: _MainSection(
                          product,
                          isWideLayout: true,
                          padding: const EdgeInsets.all(16.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          _MovieCollectionSection(product),
          _TvShowSeasonSection(product),
          _ProductRecommendationsSection(product),
        ],
      ),
    );
  }
}