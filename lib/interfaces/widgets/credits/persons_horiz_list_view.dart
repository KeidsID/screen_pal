import 'package:flutter/material.dart';

import 'package:screen_pal/configs/constants.dart';
import 'package:screen_pal/core/entities/person/person.dart';

import 'person_card.dart';

class PersonsHorizListView extends StatelessWidget {
  /// [Cast] or [Crew] list.
  final List<Person> persons;

  final double height;
  final double itemWidth;
  final EdgeInsetsGeometry padding;

  const PersonsHorizListView(
    this.persons, {
    super.key,
    this.height = 270.0,
    this.itemWidth = 160.0,
    this.padding = kHorizPadding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: padding,
        itemCount: persons.length,
        itemBuilder: (_, index) {
          final person = persons[index];

          return PersonCard(person, width: itemWidth);
        },
      ),
    );
  }
}
