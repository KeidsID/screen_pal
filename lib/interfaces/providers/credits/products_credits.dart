// coverage:ignore-file

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:screen_pal/common/service_locator/locator.dart' as service;
import 'package:screen_pal/core/entities/credits/credits.dart';
import 'package:screen_pal/core/use_cases/credits/get_movie_credits.dart';
import 'package:screen_pal/core/use_cases/credits/get_tv_show_credits.dart';

part 'products_credits.g.dart';

@riverpod
Future<Credits> movieCredits(MovieCreditsRef ref, int movieId) {
  return service.locator<GetMovieCredits>().execute(movieId);
}

@riverpod
Future<Credits> tvShowCredits(TvShowCreditsRef ref, int tvShowId) {
  return service.locator<GetTvShowCredits>().execute(tvShowId);
}
