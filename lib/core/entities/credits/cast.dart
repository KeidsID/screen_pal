import 'package:screen_pal/core/entities/credits/credit_person.dart';

final class Cast extends CreditPerson {
  @override
  String get mainRole => character.isEmpty ? '?' : character;

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
