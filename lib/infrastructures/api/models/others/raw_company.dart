// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'raw_company.freezed.dart';
part 'raw_company.g.dart';

@freezed
class RawCompany with _$RawCompany {
  const factory RawCompany({
    required int id,
    @JsonKey(name: 'logo_path') String? logoPath,
    required String name,

    /// {@macro screen_pal.infrastructures.api.models.countryCode}
    @JsonKey(name: 'origin_country') required String originCountry,
  }) = _RawCompany;

  factory RawCompany.fromJson(Map<String, dynamic> json) =>
      _$RawCompanyFromJson(json);
}
