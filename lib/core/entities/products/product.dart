import 'package:equatable/equatable.dart';

import 'package:screen_pal/core/entities/movies/movie.dart';
import 'package:screen_pal/core/entities/tv_shows/tv_show.dart';
import 'package:screen_pal/core/entities/extras/spoken_language.dart';

/// base class for [Movie] and [TvShow].
abstract base class Product extends Equatable {
  const Product({
    required this.id,
    required this.title,
    required this.overview,
    this.releaseDate,
    required this.language,
    required this.genreIds,
    this.backdropPath,
    this.posterPath,
    required this.originalTitle,
    required this.popularity,
    required this.voteAverage,
    required this.voteCount,
  });

  final int id;
  final String title;
  final String overview;
  final DateTime? releaseDate;

  /// Its in `ISO 639 1` form. Convert it after fetch List of [SpokenLanguage]
  /// from TMDB Api Server.
  final String language;
  final List<int> genreIds;
  final String? backdropPath;
  final String? posterPath;
  final String originalTitle;
  final double popularity;
  final double voteAverage;
  final int voteCount;
}
