import 'package:equatable/equatable.dart';
import 'package:screen_pal_core/src/entities.dart';

/// Base class for [Movie] and [TvShow].
abstract base class Product extends Equatable {
  const Product({
    required this.id,
    required this.title,
    required this.originalTitle,
    this.backdropImageUrl,
    this.posterImageUrl,
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
  final String? backdropImageUrl;
  final String? posterImageUrl;
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

  @override
  List<Object?> get props => [id];
}
