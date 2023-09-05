import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:screen_pal/core/entities/movie.dart';
import 'package:screen_pal/core/use_cases/movies/get_now_playing_movies.dart';
import 'package:screen_pal/core/use_cases/movies/get_popular_movies.dart';
import 'package:screen_pal/core/use_cases/movies/get_top_rated_movies.dart';
import 'package:screen_pal/core/use_cases/movies/get_upcoming_movies.dart';
import 'package:screen_pal/service_locator/locator.dart';

part 'movie_list_providers.g.dart';

@Riverpod(keepAlive: true)
Future<List<Movie>> nowPlayingMovies(NowPlayingMoviesRef ref) async {
  return locator<GetNowPlayingMovies>().execute();
}

@Riverpod(keepAlive: true)
Future<List<Movie>> popularMovies(PopularMoviesRef ref) {
  return locator<GetPopularMovies>().execute();
}

@Riverpod(keepAlive: true)
Future<List<Movie>> topRatedMovies(TopRatedMoviesRef ref) {
  return locator<GetTopRatedMovies>().execute();
}

@Riverpod(keepAlive: true)
Future<List<Movie>> upcomingMovies(UpcomingMoviesRef ref) {
  return locator<GetUpcomingMovies>().execute();
}
