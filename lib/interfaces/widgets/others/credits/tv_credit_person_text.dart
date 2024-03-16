import 'dart:math' as math;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:fl_utilities/fl_utilities.dart';

import 'package:screen_pal_core/screen_pal_core.dart';

class TvCreditPersonText extends StatelessWidget {
  const TvCreditPersonText(this.person, {super.key});

  final TvCreditPerson person;

  List<TvRoleBase> get roles => person.roles;

  /// Seperator helper from [ListView].
  int _computeActualChildCount(int itemCount) {
    return math.max(0, itemCount * 2 - 1);
  }

  @override
  Widget build(BuildContext context) {
    final style = context.textTheme.bodyMedium;

    return RichText(
      text: TextSpan(
        style: style,
        children: List.generate(
          _computeActualChildCount(roles.length),
          (index) {
            final roleBase = roles[index ~/ 2];
            final episodeCount = roleBase.episodeCount;

            if (index.isEven) {
              // item
              return TextSpan(
                children: [
                  TextSpan(
                    text: '${roleBase.role} ',
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                  TextSpan(
                    text: '(${intl.Intl.plural(
                      episodeCount,
                      other: '$episodeCount Episodes',
                      one: '$episodeCount Episode',
                    )})',
                    style: style?.applyOpacity(0.6),
                  ),
                ],
              );
            }

            // seperator
            return const TextSpan(text: ' , ');
          },
        ),
      ),
    );
  }
}
