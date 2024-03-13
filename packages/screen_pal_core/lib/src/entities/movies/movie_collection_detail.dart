import 'package:equatable/equatable.dart';
import 'package:screen_pal_core/src/entities.dart';

class MovieCollectionDetail extends Equatable {
  final int id;
  final String name;
  final String overview;
  final String? posterImageUrl;
  final String? backdropImageUrl;
  final List<Movie> parts;

  const MovieCollectionDetail({
    required this.id,
    required this.name,
    required this.overview,
    this.posterImageUrl,
    this.backdropImageUrl,
    required this.parts,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      overview,
      posterImageUrl,
      backdropImageUrl,
      parts,
    ];
  }
}
