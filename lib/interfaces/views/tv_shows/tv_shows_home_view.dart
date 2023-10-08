import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:screen_pal/interfaces/providers/movies/movie_list_providers.dart';
import 'package:screen_pal/interfaces/providers/tv_shows/tv_show_list_providers.dart';
import 'package:screen_pal/interfaces/utils/product_list_section.dart';
import 'package:screen_pal/interfaces/utils/riverpod_async_value_handlers.dart';
import 'package:screen_pal/interfaces/widgets/products/products_carousel.dart';

class TvShowsHomeView extends StatelessWidget {
  const TvShowsHomeView({super.key});

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
                  final popularTvShows = ref.watch(popularTvShowsProvider);

                  final loadingWidget = SizedBox(
                    height: 300.0,
                    child: RiverpodAsyncValueHandlers.loading(),
                  );

                  if (popularTvShows.isRefreshing) return loadingWidget;

                  return popularTvShows.when(
                    loading: () => loadingWidget,
                    error: (error, stackTrace) => SizedBox(
                      height: 300.0,
                      child: RiverpodAsyncValueHandlers.error(
                        error,
                        stackTrace,
                        action: () => ref.invalidate(popularMoviesProvider),
                      ),
                    ),
                    data: (tvShows) {
                      final filteredTvShows = (tvShows.length <= 10)
                          ? tvShows
                          : tvShows.sublist(0, 10);

                      return ProductsCarousel(
                        filteredTvShows,
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
                title: 'Airing Today',
                productProvider: airingTodayTvShowsProvider,
              ),
              const SizedBox(height: 16.0),
              ...productListSection(
                context,
                title: 'On Air',
                productProvider: onAirTvShowsProvider,
              ),
              const SizedBox(height: 16.0),
              ...productListSection(
                context,
                title: 'Top Rated',
                productProvider: topRatedTvShowsProvider,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
