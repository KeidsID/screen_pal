import 'package:equatable/equatable.dart';

import 'spoken_language.dart';

class Movie extends Equatable {
  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;

  /// Its in `ISO 639 1` form. Convert it after fetch List of [SpokenLanguage]
  /// from TMDB Api Server.
  final String language;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final DateTime? releaseDate;
  final String title;
  final double voteAverage;
  final int voteCount;

  const Movie({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.language,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    this.releaseDate,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  @override
  List<Object?> get props {
    return [
      adult,
      backdropPath,
      genreIds,
      id,
      language,
      originalTitle,
      overview,
      popularity,
      posterPath,
      releaseDate,
      title,
      voteAverage,
      voteCount,
    ];
  }
}
