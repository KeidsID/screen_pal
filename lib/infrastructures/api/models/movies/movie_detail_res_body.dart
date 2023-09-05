// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:screen_pal/core/entities/movie_collection.dart';
import 'package:screen_pal/core/entities/movie_detail.dart';
import 'package:screen_pal/infrastructures/api/models/movies/raw_genre.dart';
import 'package:screen_pal/infrastructures/api/models/movies/raw_spoken_language.dart';

part 'movie_detail_res_body.freezed.dart';
part 'movie_detail_res_body.g.dart';

/// TMDB Api response body for requesting movie detail (/movie/:movieId).
@freezed
class MovieDetailResBody with _$MovieDetailResBody {
  const MovieDetailResBody._();

  const factory MovieDetailResBody({
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

  factory MovieDetailResBody.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailResBodyFromJson(json);

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

  MovieCollection toEntity() => MovieCollection(id: id, name: name);
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
