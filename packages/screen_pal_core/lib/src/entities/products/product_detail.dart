import 'package:equatable/equatable.dart';
import 'package:screen_pal_core/src/entities.dart';

/// Base class for [MovieDetail] and [TvShowDetail].
abstract base class ProductDetail extends Equatable {
  const ProductDetail({
    required this.id,
    required this.title,
    required this.originalTitle,
    this.backdropImageUrl,
    this.posterImageUrl,
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

  final int id;
  final String title;
  final String originalTitle;
  final String? backdropImageUrl;
  final String? posterImageUrl;
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

  @override
  List<Object?> get props => [id];
}
