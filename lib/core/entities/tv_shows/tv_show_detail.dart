import 'package:screen_pal/core/entities/products/product_detail.dart';
import 'package:screen_pal/core/entities/tv_shows/episode.dart';
import 'package:screen_pal/core/entities/tv_shows/season.dart';

final class TvShowDetail extends ProductDetail {
  const TvShowDetail({
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
    required this.type,
    this.lastAirDate,
    this.lastEpisodeToAir,
    this.nextEpisodeToAir,
    required this.seasons,
    required this.episodeCount,
    required this.seasonCount,
  });

  /// Tv Show type (Scripted, Miniseries, etc).
  final String type;
  final DateTime? lastAirDate;
  final Episode? lastEpisodeToAir;
  final Episode? nextEpisodeToAir;
  final List<Season> seasons;

  /// Number of episodes.
  final int episodeCount;

  /// Number of seasons.
  final int seasonCount;

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
      type,
      lastAirDate,
      lastEpisodeToAir,
      nextEpisodeToAir,
      seasons,
      episodeCount,
      seasonCount,
    ];
  }
}
