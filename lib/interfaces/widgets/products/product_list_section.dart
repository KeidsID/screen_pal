import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:screen_pal/common/constants.dart';
import 'package:screen_pal/core/entities/products/product.dart';
import 'package:screen_pal/interfaces/utils/riverpod_async_value_handlers.dart';
import 'package:screen_pal/interfaces/widgets/others/material_text.dart';
import 'package:screen_pal/interfaces/widgets/products/product_horiz_list_view.dart';

/// {@template screen_pal.interfaces.widgets.products.ProductListSection}
/// Common product list view section on the app.
///
/// - [autoDisposeProductsProvider], primary product provider. Other providers
///   will be ignored if this is not null.
/// - [productsProvider], secondary product provider.
/// - [products], tertiary/fallback product provider.
/// {@endtemplate}
class ProductListSection extends StatelessWidget {
  /// {@macro screen_pal.interfaces.widgets.products.ProductListSection}
  const ProductListSection({
    super.key,
    required this.title,
    this.autoDisposeProductsProvider,
    this.productsProvider,
    this.products = const <Product>[],
    this.alt,
    this.padding = kHorizPadding,
  });

  /// Section header.
  final String title;

  /// Primary product provider. Other providers will be ignored if this
  /// is not null.
  final AutoDisposeFutureProvider<List<Product>>? autoDisposeProductsProvider;

  /// Secondary product provider. If this also null, then [products] value will
  /// be used instead.
  final FutureProvider<List<Product>>? productsProvider;

  /// Tertiary/Fallback product provider. If this an empty [List], then section
  /// will not be visible ([SizedBox] with zero size will be rendered instead).
  final List<Product> products;

  /// Alternative information of the section that will be displayed if the
  /// [autoDisposeProductsProvider] or [productsProvider] provide an empty
  /// [List].
  ///
  /// Note that [products] will ignore this.
  final String? alt;

  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    if (!_checkProducts()) return const SizedBox();

    if (autoDisposeProductsProvider == null && productsProvider == null) {
      return _layout(child: ProductHorizListView(products, padding: padding));
    }

    return _layout(child: Consumer(builder: (_, ref, __) {
      final prov = ref.watch(autoDisposeProductsProvider ?? productsProvider!);

      final loadingWidget = RiverpodAsyncValueHandlers.loading();

      if (prov.isRefreshing) return loadingWidget;

      return prov.when(
        loading: () => loadingWidget,
        error: (error, stackTrace) => RiverpodAsyncValueHandlers.error(
          error,
          stackTrace,
          action: () => ref.invalidate(productsProvider!),
        ),
        data: (products) {
          if (products.isEmpty) {
            return Center(
              child: MaterialText(
                alt ?? 'No data',
                style: M3TextStyles.titleMedium,
              ),
            );
          }

          return ProductHorizListView(products, padding: padding);
        },
      );
    }));
  }

  Widget _layout({Widget? child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: padding,
          child: MaterialText(title, style: kSectionTitleStyle),
        ),
        SizedBox(height: 240.0, child: child),
      ],
    );
  }

  bool _checkProducts() {
    return (autoDisposeProductsProvider != null ||
        productsProvider != null ||
        products.isNotEmpty);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties.add(kIsVisibleFlagProperty(_checkProducts()));
  }
}
