// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:screen_pal/core/entities/movies/movie.dart';
import 'package:screen_pal/infrastructures/tmdb/utils/tmdb_images_config.dart';

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

    /// {@macro screen_pal.infrastructures.api.models.languageCode}
    @JsonKey(name: 'original_language') required String originalLanguage,
    @JsonKey(name: 'original_title') required String originalTitle,
    required String overview,
    required double popularity,
    @JsonKey(name: 'poster_path') String? posterPath,

    /// {@template screen_pal.infrastructures.api.models.dateString}
    /// Its `date string` or `empty string` type. So make sure to convert it
    /// using [DateTime.tryParse].
    /// {@endtemplate}
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
      id: id,
      title: title,
      overview: overview,
      releaseDate: DateTime.tryParse(releaseDate),
      language: originalLanguage,
      genreIds: genreIds,
      backdropImageUrl:
          TmdbBackdropImageSizes.original.secureFetchUrl(backdropPath),
      posterImageUrl: TmdbPosterImageSizes.original.secureFetchUrl(posterPath),
      originalTitle: originalTitle,
      popularity: popularity,
      voteAverage: voteAverage,
      voteCount: voteCount,
      isAdult: adult,
    );
  }
}
