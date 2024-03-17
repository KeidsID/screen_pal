import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:screen_pal/interfaces/providers/remote/movies/movie_list_providers.dart';
import 'package:screen_pal/interfaces/widgets.dart';
import 'package:screen_pal_core/screen_pal_core.dart';

class MoviesHomeView extends StatelessWidget {
  const MoviesHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductsCarouselSection(popularMoviesProvider),
              const SizedBox(height: 16.0),
              _MoviesSection(
                title: 'On Theatres',
                provider: nowPlayingMoviesProvider,
              ),
              const SizedBox(height: 16.0),
              _MoviesSection(
                title: 'Top Rated',
                provider: topRatedMoviesProvider,
              ),
              // const SizedBox(height: 16.0),
              // _MoviesSection(
              //   title: 'Upcoming on Theatres',
              //   provider: upcomingMoviesProvider,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MoviesSection extends ConsumerWidget {
  const _MoviesSection({
    required this.title,
    required this.provider,
  });

  final String title;
  final FutureProvider<List<Movie>> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesAsyncValue = ref.watch(provider);

    final products = moviesAsyncValue.asData?.value ?? [];

    return ProductListSection(
      title: title,
      products: products,
      alt: moviesAsyncValue.whenOrNull(
        skipLoadingOnRefresh: false,
        loading: () => const SizedCircularProgressIndicator.expand(),
        error: (err, trace) {
          final action = ElevatedButton.icon(
            onPressed: () => ref.refresh(provider),
            icon: const Icon(Icons.refresh_outlined),
            label: const Text('Refresh'),
          );

          if (err is DioException) {
            return SizedDioExceptionWidget.expand(err, action: action);
          }

          return SizedExceptionWidget.expand(err, trace: trace, action: action);
        },
      ),
    );
  }
}
