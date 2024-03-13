import 'package:flutter/material.dart';

import 'package:screen_pal/common/constants.dart';
import 'package:screen_pal/interfaces/utils.dart';
import 'package:screen_pal/interfaces/widgets.dart';
import 'package:screen_pal_core/screen_pal_core.dart';

/// {@template lib.interfaces.widgets.others.credits.CreditPersonDetailCard}
/// Detailed version of [CreditPersonCard]
/// (Will display all roles for [TvCast]/[TvCrew]).
///
/// Please size it as horizontal widget ([width] is higher than [height]) for
/// better content view.
/// {@endtemplate}
class SizedCreditPersonDetailCard extends SizedBox {
  /// {@macro lib.interfaces.widgets.others.credits.CreditPersonDetailCard}
  SizedCreditPersonDetailCard(
    this.person, {
    super.key,
    super.width = 240.0,
    super.height = 120.0,
  }) : super(child: _builder(person));

  /// {@macro lib.interfaces.widgets.others.credits.CreditPersonDetailCard}
  ///
  /// This will become as large as its parent allows.
  SizedCreditPersonDetailCard.expand(this.person, {super.key})
      : super.expand(child: _builder(person));

  /// {@macro lib.interfaces.widgets.others.credits.CreditPersonDetailCard}
  ///
  /// This will become as small as its parent allows.
  SizedCreditPersonDetailCard.shrink(this.person, {super.key})
      : super.shrink(child: _builder(person));

  /// {@macro lib.interfaces.widgets.others.credits.CreditPersonDetailCard}
  ///
  /// This will become a box with the specified size.
  SizedCreditPersonDetailCard.fromSize(this.person, {super.key, super.size})
      : super.fromSize(child: _builder(person));

  /// {@macro lib.interfaces.widgets.others.credits.CreditPersonDetailCard}
  ///
  /// This will become a box whose [width] and [height] are equal.
  SizedCreditPersonDetailCard.square(this.person, {super.key, super.dimension})
      : super.square(child: _builder(person));

  final CreditPerson person;

  static Widget _builder(CreditPerson person) {
    return Builder(builder: (context) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // image
              AspectRatio(
                aspectRatio: kAspectRatio(),
                child: CommonNetworkImage(
                  imageUrl: person.profileImageUrl ?? '',
                  imageBuilder: (context, imgProv) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image(image: imgProv, fit: BoxFit.cover),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16.0),

              // name and roles
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        person.name,
                        style: M3TextStyles.titleLarge.toStyle(context),
                      ),
                      (person is TvCreditPerson)
                          ? TvCreditPersonText(person)
                          : Text(person.mainRole),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
