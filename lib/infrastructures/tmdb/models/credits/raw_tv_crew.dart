// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:screen_pal/infrastructures/tmdb/utils/tmdb_images_config.dart';
import 'package:screen_pal_core/screen_pal_core.dart';

part 'raw_tv_crew.freezed.dart';
part 'raw_tv_crew.g.dart';

@freezed
class RawTvCrew with _$RawTvCrew {
  const RawTvCrew._();

  const factory RawTvCrew({
    required bool adult,
    required int gender,
    required int id,
    @JsonKey(name: 'known_for_department') required String knownForDepartment,
    required String name,
    @JsonKey(name: 'original_name') required String originalName,
    required double popularity,
    @JsonKey(name: 'profile_path') String? profilePath,
    required List<RawTvCrewJob> jobs,
    required String department,
    @JsonKey(name: 'total_episode_count') required int totalEpisodeCount,
  }) = _RawTvCrew;

  factory RawTvCrew.fromJson(Map<String, dynamic> json) =>
      _$RawTvCrewFromJson(json);

  TvCrew toEntity() {
    return TvCrew(
      id: id,
      name: name,
      gender: Gender.values[gender],
      profileImageUrl:
          TmdbProfileImageSizes.original.secureFetchUrl(profilePath),
      originalName: originalName,
      knownForDepartment: knownForDepartment,
      adult: adult,
      popularity: popularity,
      department: department,
      totalEpisodeCount: totalEpisodeCount,
      roles: jobs.map((e) => e.toEntity()).toList(),
    );
  }
}

@freezed
class RawTvCrewJob with _$RawTvCrewJob {
  const RawTvCrewJob._();

  const factory RawTvCrewJob({
    @JsonKey(name: 'credit_id') required String creditId,
    required String job,
    @JsonKey(name: 'episode_count') required int episodeCount,
  }) = _RawTvCrewJob;

  factory RawTvCrewJob.fromJson(Map<String, dynamic> json) =>
      _$RawTvCrewJobFromJson(json);

  TvCrewRole toEntity() {
    return TvCrewRole(
      creditId: creditId,
      job: job,
      episodeCount: episodeCount,
    );
  }
}
