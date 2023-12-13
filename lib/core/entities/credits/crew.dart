import 'package:screen_pal/core/entities/person/person.dart';

class Crew extends Person {
  final String originalName;
  final String job;
  final String department;
  final bool adult;
  final double popularity;

  const Crew({
    required super.id,
    required super.creditId,
    required super.name,
    required super.gender,
    super.profileImageUrl,
    required this.originalName,
    required this.job,
    required this.department,
    required this.adult,
    required this.popularity,
  });

  @override
  List<Object?> get props {
    return [
      super.id,
      super.creditId,
      super.name,
      super.gender,
      super.profileImageUrl,
      originalName,
      job,
      department,
      adult,
      popularity,
    ];
  }
}
