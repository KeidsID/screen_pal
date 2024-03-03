import 'dart:math' as math;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import 'package:screen_pal/core/entities.dart';
import 'package:screen_pal/interfaces/utils/m3_text_styles.dart';

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
    const enumStyle = M3TextStyles.bodyMedium;

    return RichText(
      text: TextSpan(
        style: enumStyle.toStyle(context),
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
                    style: enumStyle.toStyle(context, opacity: 0.6),
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
