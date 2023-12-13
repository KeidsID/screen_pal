// coverage:ignore-file

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:screen_pal/infrastructures/container/container.dart' as service;
import 'package:screen_pal/core/entities/tv_shows/tv_show.dart';
import 'package:screen_pal/core/use_cases.dart';

part 'tv_show_list_providers.g.dart';

@Riverpod(keepAlive: true)
Future<List<TvShow>> airingTodayTvShows(AiringTodayTvShowsRef ref) {
  return service.locator<GetAiringTodayTvShows>().execute();
}

@Riverpod(keepAlive: true)
Future<List<TvShow>> onAirTvShows(OnAirTvShowsRef ref) {
  return service.locator<GetOnAirTvShows>().execute();
}

@Riverpod(keepAlive: true)
Future<List<TvShow>> popularTvShows(PopularTvShowsRef ref) {
  return service.locator<GetPopularTvShows>().execute();
}

@Riverpod(keepAlive: true)
Future<List<TvShow>> topRatedTvShows(TopRatedTvShowsRef ref) {
  return service.locator<GetTopRatedTvShows>().execute();
}

@riverpod
Future<List<TvShow>> tvShowRecommendations(
  TvShowRecommendationsRef ref,
  int tvShowId,
) {
  return service.locator<GetTvShowRecommendations>().execute(tvShowId);
}
