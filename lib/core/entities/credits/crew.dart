import 'package:screen_pal/core/entities/credits/credit_person.dart';

final class Crew extends CreditPerson {
  @override
  String get mainRole => job.isEmpty ? '?' : job;

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
