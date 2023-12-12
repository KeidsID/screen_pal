// coverage:ignore-file

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:screen_pal/infrastructures/service_locator/locator.dart'
    as service;
import 'package:screen_pal/core/entities/tv_shows/tv_show.dart';
import 'package:screen_pal/core/use_cases/tv_shows/get_airing_today_tv_shows.dart';
import 'package:screen_pal/core/use_cases/tv_shows/get_on_air_tv_shows.dart';
import 'package:screen_pal/core/use_cases/tv_shows/get_popular_tv_shows.dart';
import 'package:screen_pal/core/use_cases/tv_shows/get_top_rated_tv_shows.dart';
import 'package:screen_pal/core/use_cases/tv_shows/get_tv_show_recommendations.dart';

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
