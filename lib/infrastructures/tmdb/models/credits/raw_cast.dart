// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:screen_pal/core/entities/credits/cast.dart';
import 'package:screen_pal/core/entities/person/person.dart';

part 'raw_cast.freezed.dart';
part 'raw_cast.g.dart';

@freezed
class RawCast with _$RawCast {
  const RawCast._();

  const factory RawCast({
    required bool adult,
    required int gender,
    required int id,
    @JsonKey(name: 'known_for_department') required String knownForDepartment,
    required String name,
    @JsonKey(name: 'original_name') required String originalName,
    required double popularity,
    @JsonKey(name: 'profile_path') String? profilePath,
    required String character,
    @JsonKey(name: 'credit_id') required String creditId,
    required int order,
  }) = _RawCast;

  factory RawCast.fromJson(Map<String, dynamic> json) =>
      _$RawCastFromJson(json);

  Cast toEntity() {
    return Cast(
      id: id,
      creditId: creditId,
      name: name,
      gender: Gender.values[gender],
      profilePath: profilePath,
      originalName: originalName,
      character: character,
      department: knownForDepartment,
      adult: adult,
      order: order,
      popularity: popularity,
    );
  }
}
