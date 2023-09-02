import 'package:screen_pal/core/entities/movie.dart';
import 'package:screen_pal/core/entities/movie_detail.dart';

abstract class MoviesRepo {
  Future<List<Movie>> getNowPlayingMovies();
  Future<List<Movie>> getPopularMovies();
  Future<List<Movie>> getTopRatedMovies();
  Future<List<Movie>> getUpcomingMovies();

  Future<MovieDetail> getMovieDetail(int id);
}
