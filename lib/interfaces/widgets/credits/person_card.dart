import 'package:flutter/material.dart';

import 'package:screen_pal/core/entities/credits/cast.dart';
import 'package:screen_pal/core/entities/credits/crew.dart';
import 'package:screen_pal/core/entities/person/person.dart';
import 'package:screen_pal/interfaces/widgets.dart';

class PersonCard extends StatelessWidget {
  /// [Cast] or [Crew].
  final Person person;

  final double width;
  final double height;

  const PersonCard(
    this.person, {
    super.key,
    this.width = 160.0,
    this.height = 270.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: CommonNetworkImage(
                imageUrl: '${person.profileImageUrl}',
                fit: BoxFit.cover,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MaterialText(
                        person.name,
                        style: M3TextStyles.titleMedium,
                        isBold: true,
                      ),
                      _role(person),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _role(Person person) {
    final String role =
        (person is Cast) ? person.character : (person as Crew).job;

    return Text(role);
  }
}
