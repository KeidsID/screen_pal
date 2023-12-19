import 'package:flutter/material.dart';

import 'package:screen_pal/common/constants.dart';
import 'package:screen_pal/core/entities.dart';

import 'person_card.dart';

class PersonsHorizListView extends StatelessWidget {
  /// [Cast] or [Crew] list.
  final List<Person> persons;

  final double height;
  final double itemWidth;
  final EdgeInsetsGeometry padding;

  /// A widget to display after the last item of [persons].
  ///
  /// [trailing] will be wrapped with [SizedBox] to make sure it has the same
  /// size as the other items.
  final Widget? trailing;

  const PersonsHorizListView(
    this.persons, {
    super.key,
    this.height = 270.0,
    this.itemWidth = 160.0,
    this.padding = kHorizPadding,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final hasTrailing = trailing != null;

    final itemCount = hasTrailing ? persons.length + 1 : persons.length;

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

          final person = persons[index];

          return PersonCard(person, width: itemWidth);
        },
      ),
    );
  }
}
