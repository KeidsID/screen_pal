import 'package:screen_pal/core/entities/movies/movie.dart';
import 'package:screen_pal/core/entities/movies/movie_collection_detail.dart';
import 'package:screen_pal/core/entities/movies/movie_detail.dart';

/// Everything you need to manage movies.
abstract interface class MoviesRepo {
  Future<List<Movie>> getNowPlayingMovies();
  Future<List<Movie>> getPopularMovies();
  Future<List<Movie>> getTopRatedMovies();
  Future<List<Movie>> getUpcomingMovies();

  Future<MovieDetail> getMovieDetail(int movieId);
  Future<List<Movie>> getRecommendations(int movieId);
  Future<MovieCollectionDetail> getMovieCollectionDetail(int collectionId);
}
