// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:screen_pal/core/entities/movies/movie.dart';

part 'raw_movie.freezed.dart';
part 'raw_movie.g.dart';

@freezed
class RawMovie with _$RawMovie {
  const RawMovie._();

  const factory RawMovie({
    required bool adult,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    @JsonKey(name: 'genre_ids') required List<int> genreIds,
    required int id,
    @JsonKey(name: 'original_language') required String originalLanguage,
    @JsonKey(name: 'original_title') required String originalTitle,
    required String overview,
    required double popularity,
    @JsonKey(name: 'poster_path') String? posterPath,
    // return date string or empty string on response
    @JsonKey(name: 'release_date') required String releaseDate,
    required String title,
    required bool video,
    @JsonKey(name: 'vote_average') required double voteAverage,
    @JsonKey(name: 'vote_count') required int voteCount,
  }) = _RawMovie;

  factory RawMovie.fromJson(Map<String, dynamic> json) =>
      _$RawMovieFromJson(json);

  Movie toEntity() {
    return Movie(
      isAdult: adult,
      backdropPath: backdropPath,
      genreIds: genreIds,
      id: id,
      language: originalLanguage,
      originalTitle: originalTitle,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      releaseDate: DateTime.tryParse(releaseDate),
      title: title,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }
}
