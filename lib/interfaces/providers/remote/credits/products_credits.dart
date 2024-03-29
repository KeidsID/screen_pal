// coverage:ignore-file

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:screen_pal/infrastructures/container/container.dart'
    as container;
import 'package:screen_pal_core/screen_pal_core.dart';

part 'products_credits.g.dart';

@riverpod
Future<Credits> movieCredits(MovieCreditsRef ref, int movieId) {
  return container.locator<GetMovieCreditsCase>().execute(movieId);
}

@riverpod
Future<Credits> tvShowCredits(TvShowCreditsRef ref, int tvShowId) {
  return container.locator<GetTvShowCreditsCase>().execute(tvShowId);
}

@riverpod
Future<TvCredits> tvShowFullCredits(
  TvShowFullCreditsRef ref,
  int tvShowId,
) {
  return container.locator<GetTvShowFullCreditsCase>().execute(tvShowId);
}
