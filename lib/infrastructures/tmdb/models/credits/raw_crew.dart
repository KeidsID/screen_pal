// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:screen_pal/core/entities/credits/crew.dart';
import 'package:screen_pal/core/entities/person/person.dart';

part 'raw_crew.freezed.dart';
part 'raw_crew.g.dart';

@freezed
class RawCrew with _$RawCrew {
  const RawCrew._();

  const factory RawCrew({
    required bool adult,
    required int gender,
    required int id,
    @JsonKey(name: 'known_for_department') required String knownForDepartment,
    required String name,
    @JsonKey(name: 'original_name') required String originalName,
    required double popularity,
    @JsonKey(name: 'profile_path') String? profilePath,
    @JsonKey(name: 'credit_id') required String creditId,
    required String department,
    required String job,
  }) = _RawCrew;

  factory RawCrew.fromJson(Map<String, dynamic> json) =>
      _$RawCrewFromJson(json);

  Crew toEntity() {
    return Crew(
      id: id,
      creditId: creditId,
      name: name,
      gender: Gender.values[gender],
      profilePath: profilePath,
      originalName: originalName,
      job: job,
      department: department,
      popularity: popularity,
      adult: adult,
    );
  }
}
