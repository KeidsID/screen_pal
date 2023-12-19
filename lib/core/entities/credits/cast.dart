import 'package:screen_pal/core/entities/credits/person_from_credits.dart';

final class Cast extends PersonFromCredits {
  final String character;

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
}
