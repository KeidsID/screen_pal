import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:screen_pal/core/entities/products/product.dart';
import 'package:screen_pal/interfaces/utils/riverpod_async_value_handlers.dart';
import 'package:screen_pal/interfaces/widgets/apps/material_text.dart';
import 'package:screen_pal/interfaces/widgets/products/product_horiz_list_view.dart';

/// Declarative product list view section on home view.
///
/// If [productsProvider] is null, then [products] will be used instead.
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
List<Widget> productListSection({
  required String title,
  List<Product> products = const <Product>[],
  FutureProvider<List<Product>>? productsProvider,
  EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 16.0),
}) {
  return [
    Padding(
      padding: padding,
      child: MaterialText(title, style: M3TextStyles.titleLarge),
    ),
    SizedBox(
      height: 240.0,
      child: (productsProvider == null)
          ? ProductHorizListView(products, padding: padding)
          : Consumer(builder: (_, ref, __) {
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
                data: (products) =>
                    ProductHorizListView(products, padding: padding),
              );
            }),
    ),
  ];
}
