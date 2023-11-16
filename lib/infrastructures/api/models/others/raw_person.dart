// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:screen_pal/core/entities/person/person.dart';

part 'raw_person.freezed.dart';
part 'raw_person.g.dart';

@freezed
class RawPerson with _$RawPerson {
  RawPerson._();

  const factory RawPerson({
    required int id,
    @JsonKey(name: 'credit_id') required String creditId,
    required String name,
    required int gender,
    @JsonKey(name: 'profile_path') required String? profilePath,
  }) = _RawPerson;

  factory RawPerson.fromJson(Map<String, dynamic> json) =>
      _$RawPersonFromJson(json);

  Person toEntity() {
    return Person(
      id: id,
      creditId: creditId,
      name: name,
      gender: Gender.values[gender],
      profilePath: profilePath,
    );
  }
}
