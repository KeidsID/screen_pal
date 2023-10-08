import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:screen_pal/core/entities/products/product.dart';
import 'package:screen_pal/interfaces/utils/riverpod_async_value_handlers.dart';
import 'package:screen_pal/interfaces/widgets/products/products_carousel.dart';

class ProductsCarouselSection extends StatelessWidget {
  /// Carousel section on home view.
  const ProductsCarouselSection(this.productsProvider, {super.key});

  final FutureProvider<List<Product>> productsProvider;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    final carouselHeight = deviceSize.height * 0.75;
    final filteredCarouselHeight = (carouselHeight < 400.0)
        ? 400.0
        : (carouselHeight > 800.0)
            ? 800.0
            : carouselHeight;

    return SizedBox(
      height: filteredCarouselHeight,
      child: Consumer(
        builder: (_, ref, __) {
          final popularMovies = ref.watch(productsProvider);

          final loadingWidget = RiverpodAsyncValueHandlers.loading();

          if (popularMovies.isRefreshing) return loadingWidget;

          return popularMovies.when(
            loading: () => loadingWidget,
            error: (error, stackTrace) => RiverpodAsyncValueHandlers.error(
              error,
              stackTrace,
              action: () => ref.invalidate(productsProvider),
            ),
            data: (products) {
              final filteredProducts =
                  (products.length <= 10) ? products : products.sublist(0, 10);

              return ProductsCarousel(
                filteredProducts,
                height: filteredCarouselHeight,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 6),
                autoPlayAnimationDuration: const Duration(seconds: 2),
              );
            },
          );
        },
      ),
    );
  }
}
