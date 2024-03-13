import 'package:screen_pal_core/src/entities.dart';

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

  @override
  String get mainRole {
    final value = roles.firstOrNull?.character ?? '?';

    return value.isEmpty ? '?' : value;
  }
}

final class TvCastRole extends TvRoleBase {
  const TvCastRole({
    required super.creditId,
    required super.episodeCount,
    required this.character,
  });

  final String character;

  @override
  String get role => character.isEmpty ? super.role : character;
}
