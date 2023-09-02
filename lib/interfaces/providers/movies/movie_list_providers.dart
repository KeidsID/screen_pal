import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:screen_pal/core/entities/movie.dart';
import 'package:screen_pal/core/use_cases/movie/get_now_playing_movies.dart';
import 'package:screen_pal/core/use_cases/movie/get_popular_movies.dart';
import 'package:screen_pal/core/use_cases/movie/get_top_rated_movies.dart';
import 'package:screen_pal/core/use_cases/movie/get_upcoming_movies.dart';
import 'package:screen_pal/service_locator/locator.dart';

part 'movie_list_providers.g.dart';

@riverpod
Future<List<Movie>> nowPlayingMovies(NowPlayingMoviesRef ref) async {
  return locator<GetNowPlayingMovies>().execute();
}

@riverpod
Future<List<Movie>> popularMovies(PopularMoviesRef ref) {
  return locator<GetPopularMovies>().execute();
}

@riverpod
Future<List<Movie>> topRatedMovies(TopRatedMoviesRef ref) {
  return locator<GetTopRatedMovies>().execute();
}

@riverpod
Future<List<Movie>> upcomingMovies(UpcomingMoviesRef ref) {
  return locator<GetUpcomingMovies>().execute();
}
