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
