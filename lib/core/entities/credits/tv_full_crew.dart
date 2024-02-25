import 'package:equatable/equatable.dart';
import 'package:screen_pal/core/entities/credits/credit_person.dart';

/// Contains the total number of episodes and jobs so far.
final class TvFullCrew extends CreditPerson {
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

  @override
  String? get mainRole => jobs.firstOrNull?.job;
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
