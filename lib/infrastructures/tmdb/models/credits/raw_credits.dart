// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:screen_pal_core/screen_pal_core.dart';

import 'raw_cast.dart';
import 'raw_crew.dart';

part 'raw_credits.freezed.dart';
part 'raw_credits.g.dart';

@freezed
class RawCredits with _$RawCredits {
  const RawCredits._();

  const factory RawCredits({
    required int id,
    required List<RawCast> cast,
    required List<RawCrew> crew,
  }) = _RawCredits;

  factory RawCredits.fromJson(Map<String, dynamic> json) =>
      _$RawCreditsFromJson(json);

  Credits toEntity() {
    return Credits(
      productId: id,
      casts: cast.map((e) => e.toEntity()).toList(),
      crews: crew.map((e) => e.toEntity()).toList(),
    );
  }
}
