import 'package:equatable/equatable.dart';
import 'package:screen_pal/core/entities/movies/movie.dart';

class MovieCollectionDetail extends Equatable {
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final List<Movie> parts;

  const MovieCollectionDetail({
    required this.id,
    required this.name,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.parts,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      overview,
      posterPath,
      backdropPath,
      parts,
    ];
  }
}
