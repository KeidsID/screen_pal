import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_utilities/fl_utilities.dart';

import 'package:screen_pal/common/constants.dart';
import 'package:screen_pal/interfaces/widgets.dart';
import 'package:screen_pal_core/screen_pal_core.dart';

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
  /// will not be visible ([SizedBox.shrink] will be rendered instead).
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
    if (!_checkProducts()) return const SizedBox.shrink();

    if (autoDisposeProductsProvider == null && productsProvider == null) {
      return _layout(child: ProductHorizListView(products, padding: padding));
    }

    return _layout(child: Consumer(builder: (_, ref, __) {
      final watchedProv = autoDisposeProductsProvider ?? productsProvider!;
      final prov = ref.watch(watchedProv);

      return prov.when(
        skipLoadingOnRefresh: false,
        loading: () => const SizedCircularProgressIndicator.expand(),

        //
        error: (e, trace) {
          final action = ElevatedButton.icon(
            onPressed: () => ref.refresh(watchedProv),
            icon: const Icon(Icons.refresh_outlined),
            label: const Text('Refresh'),
          );

          if (e is DioException) {
            return SizedDioExceptionWidget.expand(e, action: action);
          }

          return SizedExceptionWidget.expand(e, trace: trace, action: action);
        },

        //
        data: (products) {
          if (products.isEmpty) {
            return Center(
              child: Text(
                alt ?? 'No data',
                style: context.textTheme.titleMedium,
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
          child: Builder(builder: (context) {
            return Text(title, style: kSectionTitleStyle(context));
          }),
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
