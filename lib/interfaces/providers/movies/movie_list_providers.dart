import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:screen_pal/configs/service_locator/locator.dart' as service;
import 'package:screen_pal/core/entities/movie.dart';
import 'package:screen_pal/core/use_cases/movies/get_movie_recommendations.dart';
import 'package:screen_pal/core/use_cases/movies/get_now_playing_movies.dart';
import 'package:screen_pal/core/use_cases/movies/get_popular_movies.dart';
import 'package:screen_pal/core/use_cases/movies/get_top_rated_movies.dart';
import 'package:screen_pal/core/use_cases/movies/get_upcoming_movies.dart';

part 'movie_list_providers.g.dart';

@Riverpod(keepAlive: true)
Future<List<Movie>> nowPlayingMovies(NowPlayingMoviesRef ref) async {
  return service.locator<GetNowPlayingMovies>().execute();
}

@Riverpod(keepAlive: true)
Future<List<Movie>> popularMovies(PopularMoviesRef ref) {
  return service.locator<GetPopularMovies>().execute();
}

@Riverpod(keepAlive: true)
Future<List<Movie>> topRatedMovies(TopRatedMoviesRef ref) {
  return service.locator<GetTopRatedMovies>().execute();
}

@Riverpod(keepAlive: true)
Future<List<Movie>> upcomingMovies(UpcomingMoviesRef ref) {
  return service.locator<GetUpcomingMovies>().execute();
}

@riverpod
Future<List<Movie>> movieRecommendations(
  MovieRecommendationsRef ref,
  int movieId,
) {
  return service.locator<GetMovieRecommendations>().execute(movieId);
}
