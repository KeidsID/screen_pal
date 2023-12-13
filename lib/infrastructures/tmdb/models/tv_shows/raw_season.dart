// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:screen_pal/core/entities/tv_shows/season.dart';
import 'package:screen_pal/infrastructures/tmdb/utils/tmdb_images_config.dart';

part 'raw_season.freezed.dart';
part 'raw_season.g.dart';

@freezed
class RawSeason with _$RawSeason {
  const RawSeason._();

  const factory RawSeason({
    /// {@macro screen_pal.infrastructures.api.models.dateString}
    @JsonKey(name: 'air_date') required String? airDate,
    @JsonKey(name: 'episode_count') required int episodeCount,
    required int id,
    required String name,
    required String overview,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'season_number') required int seasonNumber,
    @JsonKey(name: 'vote_average') required double voteAverage,
  }) = _RawSeason;

  factory RawSeason.fromJson(Map<String, dynamic> json) =>
      _$RawSeasonFromJson(json);

  Season toEntity() {
    return Season(
      id: id,
      seasonNumber: seasonNumber,
      name: name,
      airDate: DateTime.tryParse('$airDate'),
      posterImageUrl: TmdbPosterImageSizes.original.secureFetchUrl(posterPath),
      overview: overview,
      episodeCount: episodeCount,
      voteAverage: voteAverage,
    );
  }
}
