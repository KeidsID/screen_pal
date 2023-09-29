import 'package:equatable/equatable.dart';

import 'package:screen_pal/core/entities/extras/spoken_language.dart';

class TvShow extends Equatable {
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String name;

  /// Its in `ISO 639 1` form. Convert it after fetch List of [SpokenLanguage]
  /// from TMDB Api Server.
  final String originalLanguage;
  final String originalName;
  final String overview;
  final String? posterPath;
  final double voteAverage;

  const TvShow({
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.name,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    this.posterPath,
    required this.voteAverage,
  });

  @override
  List<Object?> get props {
    return [
      backdropPath,
      genreIds,
      id,
      name,
      originalLanguage,
      originalName,
      overview,
      posterPath,
      voteAverage,
    ];
  }
}
