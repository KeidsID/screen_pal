// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:screen_pal/infrastructures/tmdb/models/others/raw_company.dart';
import 'package:screen_pal/infrastructures/tmdb/models/others/raw_country.dart';
import 'package:screen_pal/infrastructures/tmdb/utils/tmdb_images_config.dart';
import 'package:screen_pal_core/screen_pal_core.dart';

import '../others/raw_genre.dart';
import '../others/raw_spoken_language.dart';

part 'raw_movie_detail.freezed.dart';
part 'raw_movie_detail.g.dart';

/// TMDB Api response body for requesting movie detail (/movie/:movieId).
@freezed
class RawMovieDetail with _$RawMovieDetail {
  const RawMovieDetail._();

  const factory RawMovieDetail({
    required bool adult,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    @JsonKey(name: 'belongs_to_collection')
    RawMovieCollection? belongsToCollection,
    required int budget,
    required List<RawGenre> genres,
    String? homepage,
    required int id,
    @JsonKey(name: 'imdb_id') String? imdbId,

    /// {@macro screen_pal.infrastructures.api.models.languageCode}
    @JsonKey(name: 'original_language') required String originalLanguage,
    @JsonKey(name: 'original_title') required String originalTitle,
    required String overview,
    required double popularity,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'production_companies')
    required List<RawCompany> productionCompanies,
    @JsonKey(name: 'production_countries')
    required List<RawCountry> productionCountries,

    /// {@macro screen_pal.infrastructures.api.models.dateString}
    @JsonKey(name: 'release_date') required String releaseDate,
    required int revenue,
    required int runtime,
    @JsonKey(name: 'spoken_languages')
    required List<RawSpokenLanguage> spokenLanguages,
    required String status,
    required String tagline,
    required String title,
    required bool video,
    @JsonKey(name: 'vote_average') required double voteAverage,
    @JsonKey(name: 'vote_count') required int voteCount,
  }) = _MovieDetailResBody;

  factory RawMovieDetail.fromJson(Map<String, dynamic> json) =>
      _$RawMovieDetailFromJson(json);

  MovieDetail toEntity() {
    return MovieDetail(
      id: id,
      title: title,
      originalTitle: originalTitle,
      backdropImageUrl:
          TmdbBackdropImageSizes.original.secureFetchUrl(backdropPath),
      posterImageUrl: TmdbPosterImageSizes.original.secureFetchUrl(posterPath),
      releaseDate: DateTime.tryParse(releaseDate),
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
      movieCollection: belongsToCollection?.toEntity(),
      runtime: runtime,
      budget: budget,
      revenue: revenue,
      video: video,
    );
  }
}

@freezed
class RawMovieCollection with _$RawMovieCollection {
  const RawMovieCollection._();

  const factory RawMovieCollection({
    required int id,
    required String name,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
  }) = _RawMovieCollection;

  factory RawMovieCollection.fromJson(Map<String, dynamic> json) =>
      _$RawMovieCollectionFromJson(json);

  MovieCollection toEntity() {
    return MovieCollection(
      id: id,
      name: name,
      posterImageUrl: TmdbPosterImageSizes.original.secureFetchUrl(posterPath),
      backdropImageUrl:
          TmdbBackdropImageSizes.original.secureFetchUrl(backdropPath),
    );
  }
}
