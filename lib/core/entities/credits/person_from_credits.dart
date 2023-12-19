import 'package:screen_pal/core/entities/person/person.dart';

abstract base class PersonFromCredits extends Person {
  const PersonFromCredits({
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
}
