import 'package:screen_pal/core/entities/credits/person_from_credits.dart';

final class Crew extends PersonFromCredits {
  final String job;

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
}
