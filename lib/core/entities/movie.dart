import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final bool adult;
  final String backdropPath;
  final int id;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final String title;
  final double voteAverage;
  final int voteCount;

  const Movie({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  @override
  List<Object> get props {
    return [
      adult,
      backdropPath,
      id,
      originalTitle,
      overview,
      popularity,
      posterPath,
      releaseDate,
      title,
      voteAverage,
      voteCount,
    ];
  }
}
