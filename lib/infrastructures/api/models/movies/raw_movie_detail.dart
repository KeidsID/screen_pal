// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:screen_pal/core/entities/movies/movie_collection.dart';
import 'package:screen_pal/core/entities/movies/movie_detail.dart';

import 'raw_genre.dart';
import 'raw_spoken_language.dart';

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
    @JsonKey(name: 'original_language') required String originalLanguage,
    @JsonKey(name: 'original_title') required String originalTitle,
    required String overview,
    required double popularity,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'production_companies')
    required List<ProductionCompany> productionCompanies,
    @JsonKey(name: 'production_countries')
    required List<ProductionCountry> productionCountries,
    // return date string or empty string on response
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
      adult: adult,
      backdropPath: backdropPath,
      movieCollection: belongsToCollection?.toEntity(),
      budget: budget,
      genres: genres.map((e) => e.toEntity()).toList(),
      homepage: homepage,
      id: id,
      originalLanguage: originalLanguage,
      originalTitle: originalTitle,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      releaseDate: DateTime.tryParse(releaseDate),
      revenue: revenue,
      runtime: runtime,
      status: status,
      spokenLanguages: spokenLanguages.map((e) => e.toEntity()).toList(),
      tagline: tagline,
      title: title,
      video: video,
      voteAverage: voteAverage,
      voteCount: voteCount,
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
      posterPath: posterPath,
      backdropPath: backdropPath,
    );
  }
}

@freezed
class ProductionCompany with _$ProductionCompany {
  const factory ProductionCompany({
    required int id,
    @JsonKey(name: 'logo_path') String? logoPath,
    required String name,
    @JsonKey(name: 'origin_country') required String originCountry,
  }) = _ProductionCompany;

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanyFromJson(json);
}

@freezed
class ProductionCountry with _$ProductionCountry {
  const factory ProductionCountry({
    @JsonKey(name: 'iso_3166_1') required String iso31661,
    required String name,
  }) = _ProductionCountry;

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountryFromJson(json);
}
