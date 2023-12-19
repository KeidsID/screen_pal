import 'package:equatable/equatable.dart';
import 'package:screen_pal/core/entities/credits/person_from_credits.dart';

final class TvFullCrew extends PersonFromCredits {
  const TvFullCrew({
    required super.id,
    required super.name,
    required super.gender,
    super.profileImageUrl,
    required super.originalName,
    required super.knownForDepartment,
    required super.adult,
    required super.popularity,
    required this.department,
    required this.totalEpisodeCount,
    required this.jobs,
  });

  final String department;
  final int totalEpisodeCount;
  final List<TvCrewJob> jobs;
}

class TvCrewJob extends Equatable {
  const TvCrewJob({
    required this.creditId,
    required this.job,
    required this.episodeCount,
  });

  final String creditId;
  final String job;
  final int episodeCount;

  @override
  List<Object?> get props => [creditId];
}
