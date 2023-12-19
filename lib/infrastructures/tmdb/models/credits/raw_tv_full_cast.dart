// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:screen_pal/core/entities/credits/tv_full_cast.dart';
import 'package:screen_pal/core/entities/person/person.dart';
import 'package:screen_pal/infrastructures/tmdb/utils/tmdb_images_config.dart';

part 'raw_tv_full_cast.freezed.dart';
part 'raw_tv_full_cast.g.dart';

@freezed
class RawTvFullCast with _$RawTvFullCast {
  const RawTvFullCast._();

  const factory RawTvFullCast({
    required bool adult,
    required int gender,
    required int id,
    @JsonKey(name: 'known_for_department') required String knownForDepartment,
    required String name,
    @JsonKey(name: 'original_name') required String originalName,
    required double popularity,
    @JsonKey(name: 'profile_path') String? profilePath,
    required List<RawTvCastRole> roles,
    @JsonKey(name: 'total_episode_count') required int totalEpisodeCount,
    required int order,
  }) = _RawTvFullCast;

  factory RawTvFullCast.fromJson(Map<String, dynamic> json) =>
      _$RawTvFullCastFromJson(json);

  TvFullCast toEntity() {
    return TvFullCast(
      id: id,
      name: name,
      gender: Gender.values[gender],
      profileImageUrl:
          TmdbProfileImageSizes.original.secureFetchUrl(profilePath),
      originalName: originalName,
      knownForDepartment: knownForDepartment,
      adult: adult,
      popularity: popularity,
      totalEpisodeCount: totalEpisodeCount,
      roles: roles.map((e) => e.toEntity()).toList(),
    );
  }
}

@freezed
class RawTvCastRole with _$RawTvCastRole {
  const RawTvCastRole._();

  const factory RawTvCastRole({
    @JsonKey(name: 'credit_id') required String creditId,
    required String character,
    @JsonKey(name: 'episode_count') required int episodeCount,
  }) = _RawTvCastRole;

  factory RawTvCastRole.fromJson(Map<String, dynamic> json) =>
      _$RawTvCastRoleFromJson(json);

  TvCastRole toEntity() {
    return TvCastRole(
      creditId: creditId,
      character: character,
      episodeCount: episodeCount,
    );
  }
}
