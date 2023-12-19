// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:screen_pal/core/entities/credits/tv_full_crew.dart';
import 'package:screen_pal/core/entities/person/person.dart';
import 'package:screen_pal/infrastructures/tmdb/utils/tmdb_images_config.dart';

part 'raw_tv_full_crew.freezed.dart';
part 'raw_tv_full_crew.g.dart';

@freezed
class RawTvFullCrew with _$RawTvFullCrew {
  const RawTvFullCrew._();

  const factory RawTvFullCrew({
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
  }) = _RawTvFullCrew;

  factory RawTvFullCrew.fromJson(Map<String, dynamic> json) =>
      _$RawTvFullCrewFromJson(json);

  TvFullCrew toEntity() {
    return TvFullCrew(
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
      jobs: jobs.map((e) => e.toEntity()).toList(),
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

  TvCrewJob toEntity() {
    return TvCrewJob(
      creditId: creditId,
      job: job,
      episodeCount: episodeCount,
    );
  }
}
