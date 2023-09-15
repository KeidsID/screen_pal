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
import 'package:screen_pal/interfaces/router/app_navigator.dart';
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

        final textTheme = Theme.of(context).textTheme;

        return movieDetailProv.when(
          loading: RiverpodAsyncValueHandlers.loading,
          error: (error, stackTrace) => RiverpodAsyncValueHandlers.error(
            error,
            stackTrace,
            action: () => ref.invalidate(movieDetailProvider),
          ),
          data: (movie) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LayoutBuilder(
                    builder: (_, constraints) => Container(
                      width: constraints.maxWidth,
                      height: 320.0,
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: DefaultNetworkImage(
                        imageUrl: '$tmdbImageBaseUrl${movie.backdropPath}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  ...[
                    Text(movie.title, style: textTheme.headlineLarge),
                    _ExtrasText(movie),
                    Opacity(
                      opacity: 0.5,
                      child: Text('# ${movie.tagline}'),
                    ),
                    const SizedBox(height: 8.0),
                    Text(movie.overview),
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
                    const Divider(),
                    Text('Recommendations', style: textTheme.headlineSmall),
                  ].map((e) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: e,
                    );
                  }),
                  SizedBox(
                    height: 240.0,
                    child: Consumer(builder: (_, ref, __) {
                      final movieRecommendationsProv = ref
                          .watch(movieRecommendationsProvider(widget.movieId));

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
                  ),
                ],
              ),
            );
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
