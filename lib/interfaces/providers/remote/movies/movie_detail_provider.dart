// coverage:ignore-file

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:screen_pal/infrastructures/container/container.dart' as service;
import 'package:screen_pal_core/screen_pal_core.dart';

part 'movie_detail_provider.g.dart';

@riverpod
Future<MovieDetail> movieDetail(MovieDetailRef ref, int movieId) {
  return service.locator<GetMovieDetailCase>().execute(movieId);
}
