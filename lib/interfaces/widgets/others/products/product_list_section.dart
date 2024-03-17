import 'package:fl_utilities/fl_utilities.dart';
import 'package:flutter/material.dart';

import 'package:screen_pal/common/constants.dart';
import 'package:screen_pal/interfaces/widgets.dart';
import 'package:screen_pal_core/screen_pal_core.dart';

class ProductListSection extends StatelessWidget {
  const ProductListSection({
    super.key,
    required this.title,
    this.products = const <Product>[],
    this.alt,
    this.padding = kHorizPadding,
  });

  /// Section header.
  final String title;

  final List<Product> products;

  /// Alternative widget to display if [products] is empty.
  /// 
  /// Default widget is centered "No data" text.
  final Widget? alt;

  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return _layout(child: alt ?? Center(
        child: Text('No data', style: context.textTheme.titleMedium),
      ));
    }

    return _layout(child: ProductHorizListView(products, padding: padding));
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
}
