import 'package:equatable/equatable.dart';

import 'package:screen_pal/core/entities/movies/movie.dart';
import 'package:screen_pal/core/entities/tv_shows/tv_show.dart';
import 'cast.dart';
import 'crew.dart';

class Credits extends Equatable {
  /// [Movie]/[TvShow] id
  final int productId;
  final List<Cast> casts;
  final List<Crew> crews;

  const Credits({
    required this.productId,
    required this.casts,
    required this.crews,
  });

  @override
  List<Object> get props => [productId];
}
