import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:screen_pal/interfaces/providers/movies/movie_list_providers.dart';
import 'package:screen_pal/interfaces/utils/product_list_section.dart';
import 'package:screen_pal/interfaces/utils/riverpod_async_value_handlers.dart';
import 'package:screen_pal/interfaces/widgets/products/products_carousel.dart';

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

                      return ProductsCarousel(
                        filteredMovies,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 6),
                        autoPlayAnimationDuration: const Duration(seconds: 2),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 16.0),
              ...productListSection(
                context,
                title: 'On Theatres',
                productProvider: nowPlayingMoviesProvider,
              ),
              const SizedBox(height: 16.0),
              ...productListSection(
                context,
                title: 'Top Rated',
                productProvider: topRatedMoviesProvider,
              ),
              const SizedBox(height: 16.0),
              ...productListSection(
                context,
                title: 'Upcoming on Theatres',
                productProvider: upcomingMoviesProvider,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
