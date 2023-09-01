import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:screen_pal/common/utils/riverpod_async_value_handlers.dart';
import 'package:screen_pal/core/entities/movie.dart';
import 'package:screen_pal/interfaces/providers/movies/movie_list_providers.dart';
import 'package:screen_pal/interfaces/widgets/card/movie_card.dart';
import 'package:screen_pal/interfaces/widgets/carousel/movies_carousel.dart';

class MoviesHomePage extends StatelessWidget {
  const MoviesHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    const sectionHeight = 240.0;
    const sectionPadding = EdgeInsets.symmetric(horizontal: 16.0);
    const contentWidth = 160.0;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer(
                builder: (context, ref, child) {
                  final popularMovies = ref.watch(popularMoviesProvider);

                  return popularMovies.when(
                    error: (error, stackTrace) => SizedBox(
                      height: 300.0,
                      child: RiverpodAsyncValueHandlers.error(
                        error,
                        stackTrace,
                        action: () => ref
                            .read(popularMoviesProvider.notifier)
                            .reFetchMovies(),
                      ),
                    ),
                    loading: () => SizedBox(
                      height: 300.0,
                      child: RiverpodAsyncValueHandlers.loading(),
                    ),
                    data: (movies) {
                      final filteredMovies = (movies.length <= 10)
                          ? movies
                          : movies.sublist(0, 10);

                      return MoviesCarousel(
                        movies: filteredMovies,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 6),
                        autoPlayAnimationDuration: const Duration(seconds: 2),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 16.0),
              // section
              Padding(
                padding: sectionPadding,
                child: Text('On Theatres', style: textTheme.titleLarge),
              ),
              Padding(
                padding: sectionPadding,
                child: SizedBox(
                  height: sectionHeight,
                  child: Consumer(builder: (_, ref, __) {
                    final nowPlayingMovies =
                        ref.watch(nowPlayingMoviesProvider);

                    return nowPlayingMovies.when(
                      loading: RiverpodAsyncValueHandlers.loading,
                      error: (error, stackTrace) {
                        return RiverpodAsyncValueHandlers.error(
                          error,
                          stackTrace,
                          action: () {
                            ref
                                .read(nowPlayingMoviesProvider.notifier)
                                .reFetchMovies();
                          },
                        );
                      },
                      data: (movies) {
                        return _MovieListViewHoriz(
                          movies: movies,
                          itemWidth: contentWidth,
                        );
                      },
                    );
                  }),
                ),
              ),
              const SizedBox(height: 16.0),
              // section
              Padding(
                padding: sectionPadding,
                child: Text('Top Rated', style: textTheme.titleLarge),
              ),
              Padding(
                padding: sectionPadding,
                child: SizedBox(
                  height: sectionHeight,
                  child: Consumer(builder: (_, ref, __) {
                    final topRatedMovies = ref.watch(topRatedMoviesProvider);

                    return topRatedMovies.when(
                      loading: RiverpodAsyncValueHandlers.loading,
                      error: (error, stackTrace) {
                        return RiverpodAsyncValueHandlers.error(
                          error,
                          stackTrace,
                          action: () {
                            ref
                                .read(topRatedMoviesProvider.notifier)
                                .reFetchMovies();
                          },
                        );
                      },
                      data: (movies) {
                        return _MovieListViewHoriz(
                          movies: movies,
                          itemWidth: contentWidth,
                        );
                      },
                    );
                  }),
                ),
              ),
              const SizedBox(height: 16.0),
              // section
              Padding(
                padding: sectionPadding,
                child: Text('Coming Soon', style: textTheme.titleLarge),
              ),
              Padding(
                padding: sectionPadding,
                child: SizedBox(
                  height: sectionHeight,
                  child: Consumer(builder: (_, ref, __) {
                    final upcomingMovies = ref.watch(upcomingMoviesProvider);

                    return upcomingMovies.when(
                      loading: RiverpodAsyncValueHandlers.loading,
                      error: (error, stackTrace) {
                        return RiverpodAsyncValueHandlers.error(
                          error,
                          stackTrace,
                          action: () {
                            ref
                                .read(upcomingMoviesProvider.notifier)
                                .reFetchMovies();
                          },
                        );
                      },
                      data: (movies) {
                        return _MovieListViewHoriz(
                          movies: movies,
                          itemWidth: contentWidth,
                        );
                      },
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MovieListViewHoriz extends StatelessWidget {
  const _MovieListViewHoriz({required this.movies, this.itemWidth});

  final List<Movie> movies;
  final double? itemWidth;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: movies.length,
      itemBuilder: (_, index) {
        final movie = movies[index];

        return SizedBox(width: itemWidth, child: MovieCard(movie: movie));
      },
    );
  }
}
