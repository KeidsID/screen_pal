import 'package:equatable/equatable.dart';
import 'package:screen_pal_core/src/entities.dart';

/// Contains the total number of episodes and roles (character/job) so far.
///
/// See [TvCrew] and [TvCast] for more details.
abstract base class TvCreditPerson extends CreditPerson {
  const TvCreditPerson({
    required super.id,
    required super.name,
    required super.gender,
    super.profileImageUrl,
    required super.originalName,
    required super.knownForDepartment,
    required super.adult,
    required super.popularity,
    required this.totalEpisodeCount,
  });

  final int totalEpisodeCount;

  List<TvRoleBase> get roles;

  @override
  String get mainRole => roles.firstOrNull?.role ?? '?';
}

abstract base class TvRoleBase extends Equatable {
  const TvRoleBase({
    required this.creditId,
    required this.episodeCount,
  });

  final String creditId;
  final int episodeCount;

  /// [TvCastRole.character]/[TvCrewRole.job].
  String get role => '?';

  @override
  List<Object?> get props => [creditId];
}

/// Contains the total number of episodes and character roles so far.
final class TvCast extends TvCreditPerson {
  const TvCast({
    required super.id,
    required super.name,
    required super.gender,
    super.profileImageUrl,
    required super.originalName,
    required super.knownForDepartment,
    required super.adult,
    required super.popularity,
    required super.totalEpisodeCount,
    required this.roles,
  });

  @override
  final List<TvCastRole> roles;
}

final class TvCastRole extends TvRoleBase {
  const TvCastRole({
    required super.creditId,
    required super.episodeCount,
    required this.character,
  });

  /// Character for current credit.
  ///
  /// Prefer to use [role] instead.
  final String character;

  @override
  String get role => character.isEmpty ? super.role : character;
}

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
}

final class TvCrewRole extends TvRoleBase {
  const TvCrewRole({
    required super.creditId,
    required super.episodeCount,
    required this.job,
  });

  /// Job for current credit.
  ///
  /// Prefer to use [role] instead.
  final String job;

  @override
  String get role => job.isEmpty ? super.role : job;
}
