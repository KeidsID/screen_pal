import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:screen_pal/configs/constants.dart';
import 'package:screen_pal/core/entities/movies/movie_collection.dart';

import 'package:screen_pal/core/entities/movies/movie_detail.dart';
import 'package:screen_pal/infrastructures/api/tmdb_dio.dart';
import 'package:screen_pal/interfaces/providers/extras/languages_provider.dart';
import 'package:screen_pal/interfaces/providers/movies/movie_detail_provider.dart';
import 'package:screen_pal/interfaces/providers/movies/movie_list_providers.dart';
import 'package:screen_pal/interfaces/router/app_navigator.dart';
import 'package:screen_pal/interfaces/utils/riverpod_async_value_handlers.dart';
import 'package:screen_pal/interfaces/widgets/default_network_image.dart';
import 'package:screen_pal/interfaces/widgets/list_view/movie_horiz_list_view.dart';

class MovieDetailView extends StatelessWidget {
  const MovieDetailView(this.movieId, {super.key});

  final int movieId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer(builder: (context, ref, __) {
        final movieDetailProv = ref.watch(movieDetailProvider(movieId));

        if (movieDetailProv.isRefreshing) {
          return RiverpodAsyncValueHandlers.loading();
        }

        return movieDetailProv.when(
          loading: RiverpodAsyncValueHandlers.loading,
          error: (error, stackTrace) => RiverpodAsyncValueHandlers.error(
            error,
            stackTrace,
            action: () => ref.invalidate(movieDetailProvider),
          ),
          data: (movie) {
            final mediaQuery = MediaQuery.of(context);
            final maxW = mediaQuery.size.width;
            final maxH = mediaQuery.size.height;
            final aspectRatio = mediaQuery.size.aspectRatio;

            if (maxW >= 600) {
              if (aspectRatio >= 3 / 2 && maxW > maxH) {
                return _WideDeviceLayout(movie);
              }

              return _ThinDeviceLayout(movie);
            }

            return _ThinDeviceLayout(movie);
          },
        );
      }),
    );
  }
}

const _kHorizPadding = EdgeInsets.symmetric(horizontal: 16.0);

class _MovieDetailExtrasText extends ConsumerWidget {
  const _MovieDetailExtrasText(this.movieDetail);

  final MovieDetail movieDetail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languages = ref.watch(languagesProvider);

    String language = movieDetail.language;

    if (languages.isNotEmpty) {
      language = languages.firstWhere((e) {
        return e.iso6391 == movieDetail.language;
      }).englishName;
    }

    return Opacity(
      opacity: 0.5,
      child: Text(
        [
          movieDetail.releaseDate?.year ?? 'Coming Soon',
          language,
          movieDetail.genres.isEmpty
              ? 'Undefined'
              : movieDetail.genres.map((e) => e.name).join(', ')
        ].join(' • '),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

/// [isFlexibleOverview] useful to prevent overflow on [_WideDeviceLayout], but
/// occurs a white screen error on [_ThinDeviceLayout] when running on release
/// mode. So make sure set to `false` on [_ThinDeviceLayout].
List<Widget> _mainContents(
  BuildContext context,
  MovieDetail movie, {
  bool isFlexibleOverview = true,
}) {
  final textTheme = Theme.of(context).textTheme;

  return [
    Text(movie.title, style: textTheme.headlineLarge),
    _MovieDetailExtrasText(movie),
    Opacity(
      opacity: 0.5,
      child:
          movie.tagline.isEmpty ? const SizedBox() : Text('# ${movie.tagline}'),
    ),
    const SizedBox(height: 8.0),
    isFlexibleOverview
        ? Flexible(child: Text(movie.overview))
        : Text(movie.overview),
    const Divider(),
    ...[
      Text(
        'Status: ${movie.status}',
        style: textTheme.titleSmall,
      ),
      Text(
        'Budget: '
        '${(movie.budget <= 0) ? 'No Data' : NumberFormat.currency(
            symbol: r'$',
          ).format(movie.budget)}',
        style: textTheme.titleSmall,
      ),
      Text(
        'Revenue: '
        '${(movie.revenue <= 0) ? 'No Data' : NumberFormat.currency(
            symbol: r'$',
          ).format(movie.revenue)}',
        style: textTheme.titleSmall,
      ),
    ].map((e) => Opacity(opacity: 0.75, child: e)),
  ];
}

class _MovieCollectionCard extends StatelessWidget {
  const _MovieCollectionCard(this.movieCollection, {super.key});

  final MovieCollection movieCollection;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

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
                ),
              ),
              Container(color: theme.cardColor.withOpacity(0.6)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Part of "${movieCollection.name}"',
                      style: textTheme.headlineSmall,
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

class _MovieRecommendationsHorizListView extends StatelessWidget {
  const _MovieRecommendationsHorizListView(this.movieId);

  final int movieId;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240.0,
      child: Consumer(builder: (_, ref, __) {
        final movieRecommendationsProv =
            ref.watch(movieRecommendationsProvider(movieId));

        if (movieRecommendationsProv.isRefreshing) {
          return RiverpodAsyncValueHandlers.loading();
        }

        return movieRecommendationsProv.when(
          loading: RiverpodAsyncValueHandlers.loading,
          error: (error, stackTrace) {
            return RiverpodAsyncValueHandlers.error(
              error,
              stackTrace,
              action: () {
                ref.invalidate(movieRecommendationsProvider);
              },
            );
          },
          data: (movies) {
            if (movies.isEmpty) {
              return const Center(
                child: Text('No recommendations yet'),
              );
            }

            return MovieHorizListView(movies, padding: _kHorizPadding);
          },
        );
      }),
    );
  }
}

class _ThinDeviceLayout extends StatelessWidget {
  const _ThinDeviceLayout(this.movie);

  final MovieDetail movie;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final maxW = screenSize.width;
    final maxH = screenSize.height > 800 ? 800 : screenSize.height;
    final aspectRatio = maxW / maxH;

    final isShowPoster = aspectRatio >= 2 / 3 && maxH > maxW;

    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: maxW,
            height: maxH * 0.75,
            child: DefaultNetworkImage(
              imageUrl:
                  '$tmdbImageBaseUrl${isShowPoster ? movie.posterPath : movie.backdropPath}',
              fit: BoxFit.cover,
            ),
          ),
          ...[
            ..._mainContents(context, movie, isFlexibleOverview: false),
            const Divider(),
            ...(movie.movieCollection == null
                ? [const SizedBox()]
                : [
                    _MovieCollectionCard(movie.movieCollection!),
                    const Divider(),
                  ]),
            Text('Recommendations', style: textTheme.headlineSmall),
          ].map((e) => Padding(padding: _kHorizPadding, child: e)),
          _MovieRecommendationsHorizListView(movie.id),
        ],
      ),
    );
  }
}

class _WideDeviceLayout extends StatelessWidget {
  const _WideDeviceLayout(this.movie);

  final MovieDetail movie;

  @override
  Widget build(BuildContext context) {
    final maxH = MediaQuery.of(context).size.height;
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: maxH < 400.0 ? 400.0 : maxH,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Opacity(
                  opacity: 0.15,
                  child: DefaultNetworkImage(
                    imageUrl: '$tmdbImageBaseUrl${movie.backdropPath}',
                    fit: BoxFit.cover,
                  ),
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
                              imageUrl: '$tmdbImageBaseUrl${movie.posterPath}',
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
                            children: _mainContents(context, movie),
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
          ...(movie.movieCollection == null
              ? [const SizedBox()]
              : [
                  Padding(
                    padding: _kHorizPadding,
                    child: Center(
                      child: _MovieCollectionCard(movie.movieCollection!),
                    ),
                  ),
                  const Divider(),
                ]),
          Padding(
            padding: _kHorizPadding,
            child: Text('Recommendations', style: textTheme.headlineSmall),
          ),
          _MovieRecommendationsHorizListView(movie.id),
        ],
      ),
    );
  }
}
