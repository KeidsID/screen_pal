import 'package:screen_pal/core/entities/products/product_detail.dart';

import 'movie_collection.dart';

final class MovieDetail extends ProductDetail {
  const MovieDetail({
    required super.id,
    required super.title,
    required super.originalTitle,
    super.backdropPath,
    super.posterPath,
    super.releaseDate,
    required super.overview,
    required super.language,
    required super.languages,
    required super.genres,
    required super.adult,
    required super.status,
    required super.tagline,
    super.homepage,
    required super.popularity,
    required super.voteAverage,
    required super.voteCount,
    required this.runtime,
    this.movieCollection,
    required this.budget,
    required this.revenue,
    required this.video,
  });

  /// {@template screen_pal.core.entities.runtime}
  /// Runtime in minute.
  /// {@endtemplate}
  final int runtime;
  final MovieCollection? movieCollection;
  final int budget;
  final int revenue;
  final bool video;

  @override
  List<Object?> get props {
    return [
      id,
      title,
      originalTitle,
      backdropPath,
      posterPath,
      releaseDate,
      overview,
      language,
      languages,
      genres,
      adult,
      status,
      tagline,
      homepage,
      popularity,
      voteAverage,
      voteCount,
      runtime,
      movieCollection,
      budget,
      revenue,
      video,
    ];
  }
}
