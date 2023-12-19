// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:screen_pal/core/entities.dart';
import 'raw_tv_full_cast.dart';
import 'raw_tv_full_crew.dart';

part 'raw_tv_full_credits.freezed.dart';
part 'raw_tv_full_credits.g.dart';

@freezed
class RawTvFullCredits with _$RawTvFullCredits {
  const RawTvFullCredits._();

  const factory RawTvFullCredits({
    required int id,
    required List<RawTvFullCast> cast,
    required List<RawTvFullCrew> crew,
  }) = _RawTvFullCredits;

  factory RawTvFullCredits.fromJson(Map<String, dynamic> json) =>
      _$RawTvFullCreditsFromJson(json);

  TvFullCredits toEntity() {
    return TvFullCredits(
      tvShowId: id,
      casts: cast.map((e) => e.toEntity()).toList(),
      crews: crew.map((e) => e.toEntity()).toList(),
    );
  }
}
