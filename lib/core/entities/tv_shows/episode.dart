// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'tv_show.dart';

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
  List<Object?> get props {
    return [
      id,
      seasonNumber,
      name,
      airDate,
      stillImagePath,
      overview,
      episodeNumber,
      episodeType,
      runtime,
      voteCount,
      voteAverage,
      showId,
    ];
  }
}
