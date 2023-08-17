import 'package:dio/dio.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:screen_pal/core/entities/movie.dart';
import 'package:screen_pal/interfaces/providers/movie/movie_list_providers.dart';
import 'package:screen_pal/interfaces/widgets/card/movie_card.dart';
import 'package:screen_pal/interfaces/widgets/errors/dio_exception_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    const sectionHeight = 240.0;
    const contentWidth = 160.0;

    List<Widget> section({
      required String title,
      required AutoDisposeFutureProvider<List<Movie>> moviesProvider,
    }) {
      return [
        Text(title, style: textTheme.titleLarge),
        SizedBox(
          height: sectionHeight,
          child: Consumer(builder: (context, ref, _) {
            final nowPlayingMovies = ref.watch(moviesProvider);

            return nowPlayingMovies.when(
              data: (movies) {
                return _MovieListViewHoriz(
                  movies: movies,
                  itemWidth: contentWidth,
                );
              },
              error: _providerErrorHandler,
              loading: _providerLoadingHandler,
            );
          }),
        ),
      ];
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...section(
                title: 'On Theatres',
                moviesProvider: nowPlayingMoviesProvider,
              ),
              const SizedBox(height: 16.0),
              ...section(
                title: 'Popular',
                moviesProvider: popularMoviesProvider,
              ),
              const SizedBox(height: 16.0),
              ...section(
                title: 'Top Rated',
                moviesProvider: topRatedMoviesProvider,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: theme.colorScheme.background.darken(4),
        height: kToolbarHeight,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/settings'),
        child: const Icon(Icons.settings),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _providerErrorHandler(Object err, StackTrace stackTrace) {
    if (err is! DioException) {
      debugPrint('$err');

      return Center(
        child: Text('${err.runtimeType}'),
      );
    }

    return DioExceptionPage(exception: err);
  }

  Widget _providerLoadingHandler() {
    return const Center(child: CircularProgressIndicator());
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

        return SizedBox(
          width: itemWidth,
          child: MovieCard(
            movie: movie,
            onTap: () => context.go('/movies/movie-${movie.id}'),
          ),
        );
      },
    );
  }
}
