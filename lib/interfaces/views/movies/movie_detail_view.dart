import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:screen_pal/configs/utils/native_back_button_interceptors.dart';
import 'package:screen_pal/configs/utils/riverpod_async_value_handlers.dart';
import 'package:screen_pal/core/entities/movies/movie_detail.dart';
import 'package:screen_pal/infrastructures/api/tmdb_dio.dart';
import 'package:screen_pal/interfaces/providers/extras/languages_provider.dart';
import 'package:screen_pal/interfaces/providers/movies/movie_detail_provider.dart';
import 'package:screen_pal/interfaces/providers/movies/movie_list_providers.dart';
import 'package:screen_pal/interfaces/widgets/default_network_image.dart';
import 'package:screen_pal/interfaces/widgets/list_view/movie_horiz_list_view.dart';

class MovieDetailView extends StatefulWidget {
  const MovieDetailView({super.key, required this.movieId});

  final int movieId;

  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  @override
  void initState() {
    super.initState();

    BackButtonInterceptor.add(
      NativeBackButtonInterceptors.toMovies(context),
    );
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(
      NativeBackButtonInterceptors.toMovies(context),
    );

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(onPressed: BackButtonInterceptor.popRoute),
      ),
      body: Consumer(builder: (context, ref, __) {
        final movieDetailProv = ref.watch(movieDetailProvider(widget.movieId));

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

class _ExtrasText extends ConsumerWidget {
  const _ExtrasText(this.movieDetail);

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
    _ExtrasText(movie),
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

            return MovieHorizListView(
              movies,
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
            );
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
            Text('Recommendations', style: textTheme.headlineSmall),
          ].map((e) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: e,
            );
          }),
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
    final screenSize = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: screenSize.height,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('Recommendations', style: textTheme.headlineSmall),
          ),
          _MovieRecommendationsHorizListView(movie.id),
        ],
      ),
    );
  }
}
