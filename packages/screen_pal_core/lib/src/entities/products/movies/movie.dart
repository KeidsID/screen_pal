import 'package:screen_pal_core/src/entities.dart';

final class Movie extends Product {
  const Movie({
    required super.id,
    required super.title,
    required super.overview,
    super.releaseDate,
    required super.language,
    required super.genreIds,
    super.backdropImageUrl,
    super.posterImageUrl,
    required super.originalTitle,
    required super.popularity,
    required super.voteAverage,
    required super.voteCount,
    required this.isAdult,
  });

  final bool isAdult;
}
