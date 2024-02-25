import 'package:screen_pal/core/entities.dart';

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
  /// Same as [Cast.character] or [Crew.job]. But will return the first
  /// character/job for [TvFullCast]/[TvFullCrew] type.
  String? get mainRole;
}
