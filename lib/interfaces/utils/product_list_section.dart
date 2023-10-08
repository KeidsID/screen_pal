import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:screen_pal/core/entities/products/product.dart';
import 'package:screen_pal/interfaces/utils/riverpod_async_value_handlers.dart';
import 'package:screen_pal/interfaces/widgets/products/product_horiz_list_view.dart';

/// Declarative product list view section on home view.
///
/// Use case:
/// ```dart
/// final viewChildren = [
///   // ... other section
///   ...productListSection(
///     title: 'Top Rated',
///     productProvider: topRatedMoviesProvider,
///   ),
/// ];
/// ```
List<Widget> productListSection(
  BuildContext context, {
  required String title,
  required FutureProvider<List<Product>> productsProvider,
  EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 16.0),
}) {
  final textTheme = Theme.of(context).textTheme;

  return [
    Padding(
      padding: padding,
      child: Text(title, style: textTheme.titleLarge),
    ),
    SizedBox(
      height: 240.0,
      child: Consumer(builder: (_, ref, __) {
        final movieList = ref.watch(productsProvider);

        if (movieList.isRefreshing) {
          return RiverpodAsyncValueHandlers.loading();
        }

        return movieList.when(
          loading: RiverpodAsyncValueHandlers.loading,
          error: (error, stackTrace) {
            return RiverpodAsyncValueHandlers.error(
              error,
              stackTrace,
              action: () => ref.invalidate(productsProvider),
            );
          },
          data: (products) => ProductHorizListView(products, padding: padding),
        );
      }),
    ),
  ];
}
