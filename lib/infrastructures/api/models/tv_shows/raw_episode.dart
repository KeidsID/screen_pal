// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:screen_pal/core/entities/tv_shows/episode.dart';

part 'raw_episode.freezed.dart';
part 'raw_episode.g.dart';

@freezed
class RawEpisode with _$RawEpisode {
  const RawEpisode._();

  const factory RawEpisode({
    required int id,
    required String name,
    required String overview,
    @JsonKey(name: 'vote_average') required double voteAverage,
    @JsonKey(name: 'vote_count') required int voteCount,

    /// {@macro screen_pal.infrastructures.api.models.dateString}
    @JsonKey(name: 'air_date') required String airDate,
    @JsonKey(name: 'episode_number') required int episodeNumber,
    @JsonKey(name: 'episode_type') required String episodeType,
    @JsonKey(name: 'production_code') required String productionCode,
    int? runtime,
    @JsonKey(name: 'season_number') required int seasonNumber,
    @JsonKey(name: 'show_id') required int showId,
    @JsonKey(name: 'still_path') required String? stillPath,
  }) = _RawEpisode;

  factory RawEpisode.fromJson(Map<String, dynamic> json) =>
      _$RawEpisodeFromJson(json);

  Episode toEntity() {
    return Episode(
      id: id,
      seasonNumber: seasonNumber,
      name: name,
      airDate: DateTime.tryParse(airDate),
      stillPath: stillPath,
      overview: overview,
      episodeNumber: episodeNumber,
      episodeType: episodeType,
      runtime: runtime,
      voteCount: voteCount,
      voteAverage: voteAverage,
      showId: showId,
    );
  }
}
