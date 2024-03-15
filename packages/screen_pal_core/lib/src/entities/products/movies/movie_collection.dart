import 'package:equatable/equatable.dart';

class MovieCollection extends Equatable {
  final int id;
  final String name;
  final String? posterImageUrl;
  final String? backdropImageUrl;

  const MovieCollection({
    required this.id,
    required this.name,
    this.posterImageUrl,
    this.backdropImageUrl,
  });

  @override
  List<Object?> get props => [id];
}
