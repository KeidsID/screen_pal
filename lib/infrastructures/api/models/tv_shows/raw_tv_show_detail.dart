// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:screen_pal/core/entities/tv_shows/tv_show_detail.dart';

import 'package:screen_pal/infrastructures/api/models/others/raw_company.dart';
import 'package:screen_pal/infrastructures/api/models/others/raw_country.dart';
import 'package:screen_pal/infrastructures/api/models/others/raw_genre.dart';
import 'package:screen_pal/infrastructures/api/models/others/raw_person.dart';
import 'package:screen_pal/infrastructures/api/models/others/raw_spoken_language.dart';
import 'package:screen_pal/infrastructures/api/models/tv_shows/raw_episode.dart';
import 'package:screen_pal/infrastructures/api/models/tv_shows/raw_season.dart';

part 'raw_tv_show_detail.freezed.dart';
part 'raw_tv_show_detail.g.dart';

@freezed
class RawTvShowDetail with _$RawTvShowDetail {
  const RawTvShowDetail._();

  const factory RawTvShowDetail({
    required bool adult,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    @JsonKey(name: 'created_by') required List<RawPerson> createdBy,
    @JsonKey(name: 'episode_run_time') required List<int> episodeRunTime,

    /// {@macro screen_pal.infrastructures.api.models.dateString}
    @JsonKey(name: 'first_air_date') required String firstAirDate,
    required List<RawGenre> genres,
    required String homepage,
    required int id,
    @JsonKey(name: 'in_production') required bool inProduction,

    /// {@macro screen_pal.infrastructures.api.models.languageCode}
    required List<String> languages,

    /// {@macro screen_pal.infrastructures.api.models.dateString}
    @JsonKey(name: 'last_air_date') required String lastAirDate,
    @JsonKey(name: 'last_episode_to_air') RawEpisode? lastEpisodeToAir,
    required String name,
    @JsonKey(name: 'next_episode_to_air') RawEpisode? nextEpisodeToAir,
    required List<RawCompany> networks,
    @JsonKey(name: 'number_of_episodes') required int numberOfEpisodes,
    @JsonKey(name: 'number_of_seasons') required int numberOfSeasons,

    /// {@macro screen_pal.infrastructures.api.models.countryCode}
    @JsonKey(name: 'origin_country') required List<String> originCountry,

    /// {@macro screen_pal.infrastructures.api.models.languageCode}
    @JsonKey(name: 'original_language') required String originalLanguage,
    @JsonKey(name: 'original_name') required String originalName,
    required String overview,
    required double popularity,
    @JsonKey(name: 'posted_path') String? posterPath,
    @JsonKey(name: 'production_companies')
    required List<RawCompany> productionCompanies,
    @JsonKey(name: 'production_countries')
    required List<RawCountry> productionCountries,
    required List<RawSeason> seasons,
    @JsonKey(name: 'spoken_languages')
    required List<RawSpokenLanguage> spokenLanguages,
    required String status,
    required String tagline,
    required String type,
    @JsonKey(name: 'vote_average') required double voteAverage,
    @JsonKey(name: 'vote_count') required int voteCount,
  }) = _RawTvShowDetail;

  factory RawTvShowDetail.fromJson(Map<String, dynamic> json) =>
      _$RawTvShowDetailFromJson(json);

  TvShowDetail toEntity() {
    return TvShowDetail(
      id: id,
      title: name,
      originalTitle: originalName,
      backdropPath: backdropPath,
      posterPath: posterPath,
      releaseDate: DateTime.tryParse(firstAirDate),
      overview: overview,
      language: originalLanguage,
      languages: spokenLanguages.map((e) => e.toEntity()).toList(),
      genres: genres.map((e) => e.toEntity()).toList(),
      adult: adult,
      status: status,
      tagline: tagline,
      homepage: homepage,
      popularity: popularity,
      voteAverage: voteAverage,
      voteCount: voteCount,
      type: type,
      lastAirDate: DateTime.tryParse(lastAirDate),
      lastEpisodeToAir: lastEpisodeToAir?.toEntity(),
      nextEpisodeToAir: nextEpisodeToAir?.toEntity(),
      seasons: seasons.map((e) => e.toEntity()).toList(),
      episodeCount: numberOfEpisodes,
      seasonCount: numberOfSeasons,
    );
  }
}
