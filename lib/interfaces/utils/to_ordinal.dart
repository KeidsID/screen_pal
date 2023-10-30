import 'package:flutter/material.dart';

extension OrdinalNumber on int {
  /// Format int into ordinal format (1st, 2nd, and so on).
  ///
  /// Throw error if [number] value below 1.
  String toOrdinal({Locale locale = const Locale('en', 'US')}) {
    if (this < 1) {
      throw const FormatException("Below one ordinal does'nt exists");
    }

    if (locale.languageCode == 'en') {
      if (this >= 11 && this <= 13) return '${this}th';

      switch (this % 10) {
        case 1:
          return '${this}st';
        case 2:
          return '${this}nd';
        case 3:
          return '${this}rd';
        default:
          return '${this}th';
      }
    }

    return '$this';
  }
}
