// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:screen_pal/core/entities/tv_shows/tv_show.dart';

part 'raw_tv_show.freezed.dart';
part 'raw_tv_show.g.dart';

@freezed
class RawTvShow with _$RawTvShow {
  const RawTvShow._();

  const factory RawTvShow({
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    @JsonKey(name: 'first_air_date') required DateTime firstAirDate,
    @JsonKey(name: 'genre_ids') required List<int> genreIds,
    required int id,
    required String name,
    @JsonKey(name: 'origin_country') required List<String> originCountry,
    @JsonKey(name: 'original_language') required String originalLanguage,
    @JsonKey(name: 'original_name') required String originalName,
    required String overview,
    required double popularity,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'vote_average') required double voteAverage,
    @JsonKey(name: 'vote_count') required int voteCount,
  }) = _RawTvShow;

  factory RawTvShow.fromJson(Map<String, dynamic> json) =>
      _$RawTvShowFromJson(json);

  TvShow toEntity() {
    return TvShow(
      backdropPath: backdropPath,
      genreIds: genreIds,
      id: id,
      name: name,
      originalLanguage: originalLanguage,
      originalName: originalName,
      overview: overview,
      posterPath: posterPath,
      voteAverage: voteAverage,
    );
  }
}
