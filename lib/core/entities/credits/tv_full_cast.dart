import 'package:equatable/equatable.dart';

import 'package:screen_pal/core/entities/credits/person_from_credits.dart';

/// Contains the total number of episodes and roles so far.
final class TvFullCast extends PersonFromCredits {
  const TvFullCast({
    required super.id,
    required super.name,
    required super.gender,
    super.profileImageUrl,
    required super.originalName,
    required super.knownForDepartment,
    required super.adult,
    required super.popularity,
    required this.totalEpisodeCount,
    required this.roles,
  });

  final int totalEpisodeCount;
  final List<TvCastRole> roles;
}

class TvCastRole extends Equatable {
  const TvCastRole({
    required this.creditId,
    required this.character,
    required this.episodeCount,
  });

  final String creditId;
  final String character;
  final int episodeCount;

  @override
  List<Object?> get props => [creditId];
}
