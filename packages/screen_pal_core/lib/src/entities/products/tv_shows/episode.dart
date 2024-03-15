import 'package:equatable/equatable.dart';
import 'package:screen_pal_core/src/entities.dart';

class Episode extends Equatable {
  const Episode({
    required this.id,
    required this.seasonNumber,
    required this.name,
    this.airDate,
    this.stillImagePath,
    required this.overview,
    required this.episodeNumber,
    required this.episodeType,
    this.runtime,
    required this.voteCount,
    required this.voteAverage,
    required this.showId,
  });

  final int id;
  final int seasonNumber;
  final String name;
  final DateTime? airDate;

  /// Image path.
  final String? stillImagePath;
  final String overview;
  final int episodeNumber;

  /// "standard" or "finale".
  final String episodeType;

  /// {@macro screen_pal.core.entities.runtime}
  final int? runtime;
  final int voteCount;
  final double voteAverage;

  /// Its [TvShow.id].
  final int showId;

  @override
  List<Object?> get props => [id];
}
