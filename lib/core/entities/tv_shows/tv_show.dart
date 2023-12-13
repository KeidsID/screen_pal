import 'package:screen_pal/core/entities/products/product.dart';

final class TvShow extends Product {
  const TvShow({
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
  });

  @override
  List<Object?> get props {
    return [
      id,
      title,
      overview,
      backdropImageUrl,
      posterImageUrl,
      language,
      genreIds,
      originalTitle,
      popularity,
      voteAverage,
      voteCount,
    ];
  }
}
