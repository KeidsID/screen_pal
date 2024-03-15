import 'package:screen_pal_core/src/entities.dart';

abstract base class CreditPerson extends Person {
  const CreditPerson({
    required super.id,
    required super.name,
    required super.gender,
    super.profileImageUrl,
    required this.originalName,
    required this.knownForDepartment,
    required this.adult,
    required this.popularity,
  });

  final String originalName;
  final String knownForDepartment;
  final bool adult;
  final double popularity;

  /// Get the main role of the person.
  ///
  /// Same as [Cast.character] or [Crew.job]. But will return the first role for
  /// [TvCast.roles]/[TvCrew.jobs].
  String get mainRole;
}

final class Cast extends CreditPerson {
  const Cast({
    required super.id,
    required super.name,
    required super.gender,
    super.profileImageUrl,
    required super.originalName,
    required super.knownForDepartment,
    required super.adult,
    required super.popularity,
    required this.character,
  });

  final String character;

  @override
  String get mainRole => character.isEmpty ? '?' : character;
}

final class Crew extends CreditPerson {
  const Crew({
    required super.id,
    required super.name,
    required super.gender,
    super.profileImageUrl,
    required super.originalName,
    required super.knownForDepartment,
    required super.adult,
    required super.popularity,
    required this.job,
  });

  final String job;

  @override
  String get mainRole => job.isEmpty ? '?' : job;
}
