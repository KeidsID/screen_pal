import 'package:flutter/material.dart';
import 'package:fl_utilities/fl_utilities.dart';

import 'package:screen_pal/interfaces/widgets.dart';
import 'package:screen_pal_core/screen_pal_core.dart';

class CreditPersonCard extends StatelessWidget {
  const CreditPersonCard(
    this.creditPerson, {
    super.key,
    this.width = 160.0,
    this.height = 270.0,
  });

  final CreditPerson creditPerson;

  final double width;
  final double height;

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
                imageUrl: '${creditPerson.profileImageUrl}',
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
                      Text(
                        creditPerson.name,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(creditPerson.mainRole),
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
}
