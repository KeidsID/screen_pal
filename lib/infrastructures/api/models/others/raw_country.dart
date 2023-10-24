// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'raw_country.freezed.dart';
part 'raw_country.g.dart';

@freezed
class RawCountry with _$RawCountry {
  const factory RawCountry({
    /// {@template screen_pal.infrastructures.api.models.countryCode}
    /// Its country `ISO 3166-1` code.
    /// {@endtemplate}
    @JsonKey(name: 'iso_3166_1') required String iso31661,
    required String name,
  }) = _RawCountry;

  factory RawCountry.fromJson(Map<String, dynamic> json) =>
      _$RawCountryFromJson(json);
}
