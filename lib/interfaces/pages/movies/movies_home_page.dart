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

    List<Widget> section({
      required String title,
      required FutureProvider<List<Movie>> moviesProvider,
    }) {
      return [
        Text(title, style: textTheme.titleLarge),
        SizedBox(
          height: sectionHeight,
          child: Consumer(builder: (_, ref, __) {
            final movieList = ref.watch(moviesProvider);

            if (movieList.isRefreshing) {
              return RiverpodAsyncValueHandlers.loading();
            }

            return movieList.when(
              error: (error, stackTrace) {
                return RiverpodAsyncValueHandlers.error(
                  error,
                  stackTrace,
                  action: () => ref.invalidate(moviesProvider),
                );
              },
              loading: RiverpodAsyncValueHandlers.loading,
              data: (movies) {
                return _MovieListViewHoriz(
                  movies: movies,
                  itemWidth: contentWidth,
                );
              },
            );
          }),
        ),
      ].map((e) => Padding(padding: sectionPadding, child: e)).toList();
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer(
                builder: (_, ref, __) {
                  final popularMovies = ref.watch(popularMoviesProvider);

                  final loadingWidget = SizedBox(
                    height: 300.0,
                    child: RiverpodAsyncValueHandlers.loading(),
                  );

                  if (popularMovies.isRefreshing) return loadingWidget;

                  return popularMovies.when(
                    error: (error, stackTrace) => SizedBox(
                      height: 300.0,
                      child: RiverpodAsyncValueHandlers.error(
                        error,
                        stackTrace,
                        action: () => ref.invalidate(popularMoviesProvider),
                      ),
                    ),
                    loading: () => loadingWidget,
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
              ...section(
                title: 'On Theatres',
                moviesProvider: nowPlayingMoviesProvider,
              ),
              const SizedBox(height: 16.0),
              ...section(
                title: 'Top Rated',
                moviesProvider: topRatedMoviesProvider,
              ),
              const SizedBox(height: 16.0),
              ...section(
                title: 'Coming Soon',
                moviesProvider: upcomingMoviesProvider,
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
