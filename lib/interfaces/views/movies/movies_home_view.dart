import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:screen_pal/core/entities/movies/movie.dart';
import 'package:screen_pal/interfaces/providers/movies/movie_list_providers.dart';
import 'package:screen_pal/interfaces/utils/riverpod_async_value_handlers.dart';
import 'package:screen_pal/interfaces/widgets/carousel/movies_carousel.dart';
import 'package:screen_pal/interfaces/widgets/list_view/movie_horiz_list_view.dart';

class MoviesHomeView extends StatelessWidget {
  const MoviesHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    const sectionPadding = EdgeInsets.symmetric(horizontal: 16.0);

    List<Widget> section({
      required String title,
      required FutureProvider<List<Movie>> moviesProvider,
    }) {
      return [
        Padding(
          padding: sectionPadding,
          child: Text(title, style: textTheme.titleLarge),
        ),
        SizedBox(
          height: 240.0,
          child: Consumer(builder: (_, ref, __) {
            final movieList = ref.watch(moviesProvider);

            if (movieList.isRefreshing) {
              return RiverpodAsyncValueHandlers.loading();
            }

            return movieList.when(
              loading: RiverpodAsyncValueHandlers.loading,
              error: (error, stackTrace) {
                return RiverpodAsyncValueHandlers.error(
                  error,
                  stackTrace,
                  action: () => ref.invalidate(moviesProvider),
                );
              },
              data: (movies) => MovieHorizListView(
                movies,
                padding: sectionPadding,
              ),
            );
          }),
        ),
      ];
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
                    loading: () => loadingWidget,
                    error: (error, stackTrace) => SizedBox(
                      height: 300.0,
                      child: RiverpodAsyncValueHandlers.error(
                        error,
                        stackTrace,
                        action: () => ref.invalidate(popularMoviesProvider),
                      ),
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
                title: 'Upcoming on Theatres',
                moviesProvider: upcomingMoviesProvider,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
