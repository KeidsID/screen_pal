import 'package:flutter/material.dart';

import 'package:screen_pal/interfaces/providers/tv_shows/tv_show_list_providers.dart';
import 'package:screen_pal/interfaces/utils/product_list_section.dart';
import 'package:screen_pal/interfaces/widgets/products/products_carousel_section.dart';

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
              ProductsCarouselSection(popularTvShowsProvider),
              const SizedBox(height: 16.0),
              ...productListSection(
                context,
                title: 'Airing Today',
                productsProvider: airingTodayTvShowsProvider,
              ),
              const SizedBox(height: 16.0),
              ...productListSection(
                context,
                title: 'On Air',
                productsProvider: onAirTvShowsProvider,
              ),
              const SizedBox(height: 16.0),
              ...productListSection(
                context,
                title: 'Top Rated',
                productsProvider: topRatedTvShowsProvider,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
