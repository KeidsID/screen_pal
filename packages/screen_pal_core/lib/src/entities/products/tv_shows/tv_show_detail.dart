import 'package:screen_pal_core/src/entities.dart';

final class TvShowDetail extends ProductDetail {
  const TvShowDetail({
    required super.id,
    required super.title,
    required super.originalTitle,
    super.backdropImageUrl,
    super.posterImageUrl,
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
}
