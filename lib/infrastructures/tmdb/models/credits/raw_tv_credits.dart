// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:screen_pal/core/entities.dart';
import 'raw_tv_cast.dart';
import 'raw_tv_crew.dart';

part 'raw_tv_credits.freezed.dart';
part 'raw_tv_credits.g.dart';

@freezed
class RawTvCredits with _$RawTvCredits {
  const RawTvCredits._();

  const factory RawTvCredits({
    required int id,
    required List<RawTvCast> cast,
    required List<RawTvCrew> crew,
  }) = _RawTvCredits;

  factory RawTvCredits.fromJson(Map<String, dynamic> json) =>
      _$RawTvCreditsFromJson(json);

  TvCredits toEntity() {
    return TvCredits(
      productId: id,
      casts: cast.map((e) => e.toEntity()).toList(),
      crews: crew.map((e) => e.toEntity()).toList(),
    );
  }
}
