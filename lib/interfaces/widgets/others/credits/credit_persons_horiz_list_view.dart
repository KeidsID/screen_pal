import 'package:flutter/material.dart';

import 'package:screen_pal/common/constants.dart';
import 'package:screen_pal/core/entities.dart';
import 'package:screen_pal/interfaces/widgets.dart';

class CreditPersonsHorizListView extends StatelessWidget {
  /// [Cast] or [Crew] list.
  final List<CreditPerson> creditPersons;

  final double height;
  final double itemWidth;
  final EdgeInsetsGeometry padding;

  /// A widget to display after the last item of [creditPersons].
  ///
  /// [trailing] will be wrapped with [SizedBox] to make sure it has the same
  /// size as the other items.
  final Widget? trailing;

  const CreditPersonsHorizListView(
    this.creditPersons, {
    super.key,
    this.height = 270.0,
    this.itemWidth = 160.0,
    this.padding = kHorizPadding,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final hasTrailing = trailing != null;

    final itemCount =
        hasTrailing ? creditPersons.length + 1 : creditPersons.length;

    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: padding,
        itemCount: itemCount,
        itemBuilder: (_, index) {
          if (hasTrailing && index == (itemCount - 1)) {
            return SizedBox(width: itemWidth, child: trailing);
          }

          final person = creditPersons[index];

          return CreditPersonCard(person, width: itemWidth);
        },
      ),
    );
  }
}
