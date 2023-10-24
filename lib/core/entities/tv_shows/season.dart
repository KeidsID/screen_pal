import 'package:equatable/equatable.dart';

final class Season extends Equatable {
  const Season({
    required this.id,
    required this.seasonNumber,
    required this.name,
    this.airDate,
    this.posterPath,
    required this.overview,
    required this.episodeCount,
    required this.voteAverage,
  });

  final int id;
  final int seasonNumber;
  final String name;
  final DateTime? airDate;
  final String? posterPath;
  final String overview;
  final int episodeCount;
  final double voteAverage;

  @override
  List<Object?> get props {
    return [
      id,
      seasonNumber,
      name,
      airDate,
      posterPath,
      overview,
      episodeCount,
      voteAverage,
    ];
  }
}
