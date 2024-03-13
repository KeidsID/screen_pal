import 'package:flutter/material.dart';

import 'package:screen_pal/interfaces/widgets/others/products/product_card.dart';
import 'package:screen_pal_core/screen_pal_core.dart';

class ProductHorizListView extends StatelessWidget {
  const ProductHorizListView(
    this.products, {
    super.key,
    this.height = 240.0,
    this.itemWidth = 160.0,
    this.padding,
  });

  final List<Product> products;

  final double height;
  final double itemWidth;

  /// [ListView] padding, not item padding/gap.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: padding,
        itemCount: products.length,
        itemBuilder: (_, index) {
          final product = products[index];

          return SizedBox(width: itemWidth, child: ProductCard(product));
        },
      ),
    );
  }
}
