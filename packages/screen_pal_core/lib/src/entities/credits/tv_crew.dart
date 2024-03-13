import 'package:screen_pal_core/src/entities.dart';

/// Contains the total number of episodes and jobs so far.
final class TvCrew extends TvCreditPerson {
  const TvCrew({
    required super.id,
    required super.name,
    required super.gender,
    super.profileImageUrl,
    required super.originalName,
    required super.knownForDepartment,
    required super.adult,
    required super.popularity,
    required super.totalEpisodeCount,
    required this.department,
    required this.roles,
  });

  /// Department for current credit.
  final String department;

  @override
  final List<TvCrewRole> roles;

  @override
  String get mainRole {
    final value = roles.firstOrNull?.job ?? '?';

    return value.isEmpty ? '?' : value;
  }
}

final class TvCrewRole extends TvRoleBase {
  const TvCrewRole({
    required super.creditId,
    required super.episodeCount,
    required this.job,
  });

  final String job;

  @override
  String get role => job.isEmpty ? super.role : job;
}
