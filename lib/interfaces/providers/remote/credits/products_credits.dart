// coverage:ignore-file

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:screen_pal/infrastructures/container/container.dart'
    as container;
import 'package:screen_pal/core/entities/credits/credits.dart';
import 'package:screen_pal/core/use_cases/remote/credits/get_movie_credits.dart';
import 'package:screen_pal/core/use_cases/remote/credits/get_tv_show_credits.dart';

part 'products_credits.g.dart';

@riverpod
Future<Credits> movieCredits(MovieCreditsRef ref, int movieId) {
  return container.locator<GetMovieCredits>().execute(movieId);
}

@riverpod
Future<Credits> tvShowCredits(TvShowCreditsRef ref, int tvShowId) {
  return container.locator<GetTvShowCredits>().execute(tvShowId);
}
