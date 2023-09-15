import 'package:equatable/equatable.dart';

class MovieCollection extends Equatable {
  final int id;
  final String name;
  final String? posterPath;
  final String? backdropPath;

  const MovieCollection({
    required this.id,
    required this.name,
    this.posterPath,
    this.backdropPath,
  });

  @override
  List<Object?> get props => [id, name, posterPath, backdropPath];
}
