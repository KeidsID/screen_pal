import 'package:equatable/equatable.dart';

import 'package:screen_pal/core/entities/movie_collection.dart';
import 'package:screen_pal/core/entities/genre.dart';

class MovieDetail extends Equatable {
  final bool adult;
  final String? backdropPath;
  final MovieCollection? movieCollection;
  final int budget;
  final List<Genre> genres;
  final String? homepage;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final DateTime? releaseDate;
  final int revenue;
  final int runtime;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  const MovieDetail({
    required this.adult,
    this.backdropPath,
    this.movieCollection,
    required this.budget,
    required this.genres,
    this.homepage,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  @override
  List<Object?> get props {
    return [
      adult,
      backdropPath,
      budget,
      genres,
      homepage,
      id,
      originalLanguage,
      originalTitle,
      overview,
      popularity,
      posterPath,
      releaseDate,
      revenue,
      runtime,
      status,
      tagline,
      title,
      video,
      voteAverage,
      voteCount,
    ];
  }
}
