import 'package:equatable/equatable.dart';

enum Gender {
  /// No data for it.
  notSet,
  female,
  male,
  nonBinary,
}

class Person extends Equatable {
  final int id;
  final String creditId;
  final String name;
  final Gender gender;
  final String? profilePath;

  const Person({
    required this.id,
    required this.creditId,
    required this.name,
    required this.gender,
    this.profilePath,
  });

  @override
  List<Object?> get props {
    return [
      id,
      creditId,
      name,
      gender,
      profilePath,
    ];
  }
}
