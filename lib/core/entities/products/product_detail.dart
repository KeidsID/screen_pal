import 'package:equatable/equatable.dart';

import 'package:screen_pal/core/entities/extras/genre.dart';
import 'package:screen_pal/core/entities/extras/spoken_language.dart';

/// Base class for [MovieDetail] and [TvShowDetail].
abstract base class ProductDetail extends Equatable {
  final int id;
  final String title;
  final String originalTitle;
  final String? backdropPath;
  final String? posterPath;
  final DateTime? releaseDate;
  final String overview;

  /// {@macro screen_pal.core.entities.products.Product.language}
  ///
  /// Or try to fecth it from [languages] property.
  final String language;
  final List<SpokenLanguage> languages;
  final List<Genre> genres;
  final bool adult;
  final String status;
  final String tagline;
  final String? homepage;
  final double popularity;
  final double voteAverage;
  final int voteCount;

  const ProductDetail({
    required this.id,
    required this.title,
    required this.originalTitle,
    this.backdropPath,
    this.posterPath,
    this.releaseDate,
    required this.overview,
    required this.language,
    required this.languages,
    required this.genres,
    required this.adult,
    required this.status,
    required this.tagline,
    this.homepage,
    required this.popularity,
    required this.voteAverage,
    required this.voteCount,
  });
}
