// coverage:ignore-file

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:screen_pal/infrastructures/container/container.dart' as service;
import 'package:screen_pal/core/entities/movies/movie_detail.dart';
import 'package:screen_pal/core/use_cases/remote/movies/get_movie_detail.dart';

part 'movie_detail_provider.g.dart';

@riverpod
Future<MovieDetail> movieDetail(MovieDetailRef ref, int movieId) {
  return service.locator<GetMovieDetail>().execute(movieId);
}
