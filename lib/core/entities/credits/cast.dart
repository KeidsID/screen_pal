import 'package:screen_pal/core/entities/person/person.dart';

class Cast extends Person {
  final String originalName;
  final String character;
  final String department;
  final bool adult;
  final int order;
  final double popularity;

  const Cast({
    required super.id,
    required super.creditId,
    required super.name,
    required super.gender,
    super.profileImageUrl,
    required this.originalName,
    required this.character,
    required this.department,
    required this.adult,
    required this.order,
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
      character,
      department,
      adult,
      order,
      popularity,
    ];
  }
}
