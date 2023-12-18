import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:screen_pal/core/entities/products/product.dart';
import 'package:screen_pal/interfaces/widgets.dart';

class ProductsCarouselSection extends StatelessWidget {
  /// Carousel section on home view.
  const ProductsCarouselSection(this.productsProvider, {super.key});

  final FutureProvider<List<Product>> productsProvider;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    final height = deviceSize.height * 0.75;
    final maxH = (height < 400.0)
        ? 400.0
        : (height > 800.0)
            ? 800.0
            : height;

    return SizedBox(
      height: maxH,
      child: Consumer(
        builder: (_, ref, __) {
          final popularMovies = ref.watch(productsProvider);

          return popularMovies.when(
            skipLoadingOnRefresh: false,
            loading: () => const SizedCircularProgressIndicator.expand(),

            //
            error: (e, trace) {
              final action = ElevatedButton.icon(
                onPressed: () => ref.refresh(productsProvider),
                icon: const Icon(Icons.refresh_outlined),
                label: const Text('Refresh'),
              );

              if (e is DioException) {
                return SizedDioExceptionWidget.expand(e, action: action);
              }

              return SizedExceptionWidget.expand(
                e,
                trace: trace,
                action: action,
              );
            },

            //
            data: (products) {
              final filteredProducts =
                  (products.length <= 10) ? products : products.sublist(0, 10);

              return ProductsCarousel(
                filteredProducts,
                height: maxH,
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
