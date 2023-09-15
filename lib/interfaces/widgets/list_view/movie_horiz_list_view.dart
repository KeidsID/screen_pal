import 'package:flutter/material.dart';

import 'package:screen_pal/core/entities/movies/movie.dart';
import 'package:screen_pal/interfaces/widgets/card/movie_card.dart';

class MovieHorizListView extends StatelessWidget {
  /// Create a horizontal [ListView] with [MovieCard] items.
  const MovieHorizListView(
    this.movies, {
    super.key,
    this.height = 240.0,
    this.itemWidth = 160.0,
    this.padding,
  });

  final List<Movie> movies;

  final double height;
  final double itemWidth;

  /// [ListView] padding, not item padding/gap.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: padding,
        itemCount: movies.length,
        itemBuilder: (_, index) {
          final movie = movies[index];

          return SizedBox(width: itemWidth, child: MovieCard(movie: movie));
        },
      ),
    );
  }
}
