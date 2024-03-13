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
  final String name;
  final Gender gender;
  final String? profileImageUrl;

  const Person({
    required this.id,
    required this.name,
    required this.gender,
    this.profileImageUrl,
  });

  @override
  List<Object?> get props => [id];
}
