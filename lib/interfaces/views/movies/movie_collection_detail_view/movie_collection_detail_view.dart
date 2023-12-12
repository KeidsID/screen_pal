import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:screen_pal/common/constants.dart';
import 'package:screen_pal/core/entities/movies/movie_collection_detail.dart';
import 'package:screen_pal/infrastructures/api/tmdb_dio.dart';
import 'package:screen_pal/interfaces/providers/extras/genres_providers.dart';
import 'package:screen_pal/interfaces/providers/movies/movie_collection_detail_provider.dart';
import 'package:screen_pal/interfaces/utils/riverpod_async_value_handlers.dart';
import 'package:screen_pal/interfaces/widgets.dart';

part 'sections/_main_section.dart';

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
            height: (maxH * 0.8) - kToolbarHeight,
            child: DefaultNetworkImage(
              imageUrl: '$tmdbImageBaseUrl'
                  '${isShowPoster ? movieCollection.posterPath : movieCollection.backdropPath}',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16.0),
          _MainSection(movieCollection),
          const Padding(padding: kHorizPadding, child: Divider()),
          ProductListSection(title: 'Movies', products: movieCollection.parts),
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
                        child: _MainSection(
                          movieCollection,
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
          ProductListSection(title: 'Movies', products: movieCollection.parts),
        ],
      ),
    );
  }
}
