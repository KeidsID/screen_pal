import 'package:flutter/material.dart';

import 'package:screen_pal/interfaces/providers/movies/movie_list_providers.dart';
import 'package:screen_pal/interfaces/widgets.dart';

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
              ProductListSection(
                title: 'On Theatres',
                productsProvider: nowPlayingMoviesProvider,
              ),
              const SizedBox(height: 16.0),
              ProductListSection(
                title: 'Top Rated',
                productsProvider: topRatedMoviesProvider,
              ),
              const SizedBox(height: 16.0),
              ProductListSection(
                title: 'Upcoming on Theatres',
                productsProvider: upcomingMoviesProvider,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
