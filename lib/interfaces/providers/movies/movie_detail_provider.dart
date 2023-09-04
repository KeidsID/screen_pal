import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:screen_pal/core/entities/movie_detail.dart';
import 'package:screen_pal/core/use_cases/movie/get_movie_detail.dart';
import 'package:screen_pal/service_locator/locator.dart';

part 'movie_detail_provider.g.dart';

@riverpod
Future<MovieDetail> movieDetail(MovieDetailRef ref, int movieId) {
  return locator<GetMovieDetail>().execute(movieId);
}
