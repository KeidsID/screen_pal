import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:screen_pal/core/entities/movies/movie_collection_detail.dart';
import 'package:screen_pal/infrastructures/api/tmdb_dio.dart';
import 'package:screen_pal/interfaces/providers/extras/genres_providers.dart';
import 'package:screen_pal/interfaces/providers/movies/movie_collection_detail_provider.dart';
import 'package:screen_pal/interfaces/utils/product_list_section.dart';
import 'package:screen_pal/interfaces/utils/riverpod_async_value_handlers.dart';
import 'package:screen_pal/interfaces/widgets/others/default_network_image.dart';
import 'package:screen_pal/interfaces/widgets/others/material_text.dart';
import 'package:screen_pal/interfaces/widgets/products/product_horiz_list_view.dart';

const _kHorizPadding = EdgeInsets.symmetric(horizontal: 16.0);

class MovieCollectionDetailView extends StatelessWidget {
  const MovieCollectionDetailView(this.collectionId, {super.key});

  final int collectionId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer(builder: (context, ref, __) {
        final movieCollectionDetailProv =
            ref.watch(movieCollectionDetailProvider(collectionId));

        if (movieCollectionDetailProv.isRefreshing) {
          return RiverpodAsyncValueHandlers.loading();
        }

        return movieCollectionDetailProv.when(
          loading: RiverpodAsyncValueHandlers.loading,
          error: (error, stackTrace) => RiverpodAsyncValueHandlers.error(
            error,
            stackTrace,
            action: () => ref.invalidate(movieCollectionDetailProvider),
          ),
          data: (movieCollectionDetail) {
            final mediaQuery = MediaQuery.of(context);
            final maxW = mediaQuery.size.width;
            final maxH = mediaQuery.size.height;
            final aspectRatio = mediaQuery.size.aspectRatio;

            if (maxW >= 600) {
              if (aspectRatio >= 3 / 2 && maxW > maxH) {
                return _WideDeviceLayout(movieCollectionDetail);
              }

              return _ThinDeviceLayout(movieCollectionDetail);
            }

            return _ThinDeviceLayout(movieCollectionDetail);
          },
        );
      }),
    );
  }
}

List<Widget> _mainContents(
  MovieCollectionDetail movieCollection, {
  bool isWideLayout = false,
}) {
  return [
    MaterialText(movieCollection.name, style: M3TextStyles.headlineLarge),
    _CollectionGenresText(movieCollection),
    const SizedBox(height: 8.0),
    isWideLayout
        ? Expanded(
            child: SingleChildScrollView(child: Text(movieCollection.overview)),
          )
        : Text(movieCollection.overview),
    const Divider(),
    MaterialText(
      'Movie count: ${movieCollection.parts.length}',
      style: M3TextStyles.titleSmall,
      opacity: 0.75,
    ),
  ];
}

class _CollectionGenresText extends ConsumerWidget {
  const _CollectionGenresText(this.movieCollectionDetail);

  final MovieCollectionDetail movieCollectionDetail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final genres = ref.watch(movieGenresProvider);

    List<String> genreNames = [];

    if (genres.isNotEmpty) {
      final List<List<int>> genreIdsList = movieCollectionDetail.parts.map((e) {
        return e.genreIds;
      }).toList();

      final List<int> collectionGenreIds =
          genreIdsList.expand((e) => e).toSet().toList();

      genreNames = collectionGenreIds.map((id) {
        return genres.firstWhere((e) => e.id == id).name;
      }).toList();
    }

    return MaterialText(
      genreNames.isEmpty ? 'Undefined' : genreNames.join(', '),
      opacity: 0.5,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _ThinDeviceLayout extends StatelessWidget {
  const _ThinDeviceLayout(this.movieCollection);

  final MovieCollectionDetail movieCollection;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final maxW = screenSize.width;
    final maxH = screenSize.height > 800 ? 800 : screenSize.height;
    final aspectRatio = maxW / maxH;

    final isShowPoster = aspectRatio >= 2 / 3 && maxH > maxW;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: maxW,
            height: maxH * 0.75,
            child: DefaultNetworkImage(
              imageUrl:
                  '$tmdbImageBaseUrl${isShowPoster ? movieCollection.posterPath : movieCollection.backdropPath}',
              fit: BoxFit.cover,
            ),
          ),
          ...[
            ..._mainContents(movieCollection),
            const Divider(),
            const MaterialText('Movies', style: M3TextStyles.headlineSmall),
          ].map((e) {
            return Padding(
              padding: _kHorizPadding,
              child: e,
            );
          }),
          ProductHorizListView(movieCollection.parts, padding: _kHorizPadding),
        ],
      ),
    );
  }
}

class _WideDeviceLayout extends StatelessWidget {
  const _WideDeviceLayout(this.movieCollection);

  final MovieCollectionDetail movieCollection;

  @override
  Widget build(BuildContext context) {
    final maxH = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: (maxH < 400.0 ? 400.0 : maxH) - kToolbarHeight,
            child: Stack(
              fit: StackFit.expand,
              children: [
                DefaultNetworkImage(
                  imageUrl: '$tmdbImageBaseUrl${movieCollection.backdropPath}',
                  fit: BoxFit.cover,
                  color: Colors.white.withOpacity(0.15),
                  colorBlendMode: BlendMode.modulate,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 4,
                        child: AspectRatio(
                          aspectRatio: 2 / 3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: DefaultNetworkImage(
                              imageUrl:
                                  '$tmdbImageBaseUrl${movieCollection.posterPath}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _mainContents(
                              movieCollection,
                              isWideLayout: true,
                            ),
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
          ...productListSection(
            title: 'Movies',
            products: movieCollection.parts,
          ),
        ],
      ),
    );
  }
}
