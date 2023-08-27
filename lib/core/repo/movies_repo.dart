import 'package:screen_pal/core/entities/movie.dart';

abstract class MoviesRepo {
  Future<List<Movie>> getNowPlayingMovies();
  Future<List<Movie>> getPopularMovies();
  Future<List<Movie>> getTopRatedMovies();
  Future<List<Movie>> getUpcomingMovies();
}
