import 'package:equatable/equatable.dart';

import 'package:screen_pal/core/entities/movies/movie.dart';
import 'package:screen_pal/core/entities/tv_shows/tv_show.dart';
import 'package:screen_pal/core/entities/extras/spoken_language.dart';

/// Base class for [Movie] and [TvShow].
abstract base class Product extends Equatable {
  const Product({
    required this.id,
    required this.title,
    required this.originalTitle,
    this.backdropPath,
    this.posterPath,
    this.releaseDate,
    required this.overview,
    required this.language,
    required this.genreIds,
    required this.popularity,
    required this.voteAverage,
    required this.voteCount,
  });

  final int id;
  final String title;
  final String originalTitle;
  final String? backdropPath;
  final String? posterPath;
  final String overview;
  final DateTime? releaseDate;

  /// {@template screen_pal.core.entities.products.Product.language}
  /// Its language `ISO 639-1` code. Convert it after fetch [List] of
  /// [SpokenLanguage] from TMDB Api Server.
  /// {@endtemplate}
  final String language;
  final List<int> genreIds;
  final double popularity;
  final double voteAverage;
  final int voteCount;
}
