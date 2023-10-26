import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:screen_pal/core/entities/movies/movie_collection.dart';
import 'package:screen_pal/core/entities/movies/movie_detail.dart';
import 'package:screen_pal/core/entities/products/product_detail.dart';
import 'package:screen_pal/core/entities/tv_shows/tv_show_detail.dart';
import 'package:screen_pal/infrastructures/api/tmdb_dio.dart';
import 'package:screen_pal/interfaces/providers/movies/movie_list_providers.dart';
import 'package:screen_pal/interfaces/providers/tv_shows/tv_show_list_providers.dart';
import 'package:screen_pal/interfaces/router/app_navigator.dart';
import 'package:screen_pal/interfaces/utils/riverpod_async_value_handlers.dart';
import 'package:screen_pal/interfaces/widgets/others/default_network_image.dart';
import 'package:screen_pal/interfaces/widgets/others/material_text.dart';
import 'package:screen_pal/interfaces/widgets/products/product_horiz_list_view.dart';

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

const _kContentHorizPadding = EdgeInsets.symmetric(horizontal: 16.0);
const _kBottomPadding = EdgeInsets.only(bottom: 16.0);

class _ProductDetailExtrasText extends StatelessWidget {
  const _ProductDetailExtrasText(this.product);

  final ProductDetail product;

  @override
  Widget build(BuildContext context) {
    final languages = product.languages;

    return MaterialText(
      [
        product.releaseDate?.year ?? 'Coming Soon',
        languages.firstWhere((e) => e.iso6391 == product.language).englishName,
        product.genres.isEmpty
            ? 'Undefined'
            : product.genres.map((e) => e.name).join(', ')
      ].join(' • '),
      opacity: 0.5,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

List<Widget> _mainContents(
  ProductDetail product, {
  bool isWideLayout = false,
}) {
  List<MaterialText> statsDetail(ProductDetail product) {
    late List<String> contents;

    if (product is MovieDetail) {
      final budget = (product.budget <= 0)
          ? 'No Data'
          : NumberFormat.currency(symbol: r'$').format(product.budget);
      final revenue = (product.revenue <= 0)
          ? 'No Data'
          : NumberFormat.currency(symbol: r'$').format(product.revenue);

      contents = [
        'Status: ${product.status}',
        'Budget: $budget',
        'Revenue: $revenue',
      ];
    } else if (product is TvShowDetail) {
      final nextAirDate = (product.nextEpisodeToAir?.airDate == null)
          ? 'No Data'
          : DateFormat.yMMMd().format(product.nextEpisodeToAir!.airDate!);

      contents = [
        'Status: ${product.status}',
        'Season count: ${product.seasonCount}',
        'Next air date: $nextAirDate'
      ];
    }

    return contents.map((text) {
      return MaterialText(text, style: M3TextStyles.titleSmall, opacity: 0.75);
    }).toList();
  }

  return [
    MaterialText(product.title, style: M3TextStyles.headlineLarge),
    _ProductDetailExtrasText(product),
    product.tagline.isEmpty
        ? const SizedBox()
        : MaterialText('# ${product.tagline}', opacity: 0.5),
    const SizedBox(height: 8.0),
    isWideLayout
        ? Expanded(child: SingleChildScrollView(child: Text(product.overview)))
        : Text(product.overview),
    const Divider(),
    ...statsDetail(product),
  ];
}

class _MovieCollectionCard extends StatelessWidget {
  const _MovieCollectionCard(this.movieCollection);

  final MovieCollection movieCollection;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600.0,
      height: 240.0,
      child: Card(
        child: InkWell(
          onTap: () =>
              AppNavigator.movieCollection(context, movieCollection.id),
          child: Stack(
            fit: StackFit.expand,
            children: [
              DefaultNetworkImage(
                imageUrl: '$tmdbImageBaseUrl${movieCollection.backdropPath}',
                imageBuilder: (_, imgProvider) => Ink.image(
                  image: imgProvider,
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.25),
                    BlendMode.modulate,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MaterialText(
                      'Part of ${movieCollection.name}',
                      style: M3TextStyles.headlineSmall,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Widget> _movieCollectionSection(ProductDetail product) {
  if (product is! MovieDetail) return [];

  final movieCollection = product.movieCollection;

  return (movieCollection == null)
      ? []
      : [Center(child: _MovieCollectionCard(movieCollection)), const Divider()];
}

class _ProductRecommendationsHorizListView extends StatelessWidget {
  const _ProductRecommendationsHorizListView(this.product);

  final ProductDetail product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240.0,
      child: Consumer(builder: (_, ref, __) {
        final provider = (product is MovieDetail)
            ? ref.watch(movieRecommendationsProvider(product.id))
            : ref.watch(tvShowRecommendationsProvider(product.id));

        if (provider.isRefreshing) {
          return RiverpodAsyncValueHandlers.loading();
        }

        return provider.when(
          loading: RiverpodAsyncValueHandlers.loading,
          error: (error, stackTrace) {
            return RiverpodAsyncValueHandlers.error(
              error,
              stackTrace,
              action: () {
                if (product is MovieDetail) {
                  ref.invalidate(movieRecommendationsProvider);
                  return;
                }

                ref.invalidate(tvShowRecommendationsProvider);
              },
            );
          },
          data: (products) {
            if (products.isEmpty) {
              return const Center(child: Text('No recommendations yet'));
            }

            return ProductHorizListView(
              products,
              padding: _kContentHorizPadding,
            );
          },
        );
      }),
    );
  }
}

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
      padding: _kBottomPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: maxW,
            height: (maxH * 0.8) - kToolbarHeight,
            child: DefaultNetworkImage(
              imageUrl:
                  '$tmdbImageBaseUrl${isShowPoster ? product.posterPath : product.backdropPath}',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16.0),
          ...[
            ..._mainContents(product),
            const Divider(),
            ..._movieCollectionSection(product),
            const MaterialText(
              'Recommendations',
              style: M3TextStyles.headlineSmall,
            ),
          ].map((e) => Padding(padding: _kContentHorizPadding, child: e)),
          _ProductRecommendationsHorizListView(product),
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
      padding: _kBottomPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: (maxH < minH ? minH : maxH) - kToolbarHeight,
            child: Stack(
              fit: StackFit.expand,
              children: [
                DefaultNetworkImage(
                  imageUrl: '$tmdbImageBaseUrl${product.backdropPath}',
                  fit: BoxFit.cover,
                  color: Colors.white.withOpacity(0.1),
                  colorBlendMode: BlendMode.modulate,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 2,
                        child: AspectRatio(
                          aspectRatio: 2 / 3,
                          child: Card(
                            child: DefaultNetworkImage(
                              imageUrl:
                                  '$tmdbImageBaseUrl${product.posterPath}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                _mainContents(product, isWideLayout: true),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          ...[
            ..._movieCollectionSection(product),
            const MaterialText(
              'Recommendations',
              style: M3TextStyles.headlineSmall,
            ),
          ].map((e) => Padding(padding: _kContentHorizPadding, child: e)),
          _ProductRecommendationsHorizListView(product),
        ],
      ),
    );
  }
}
