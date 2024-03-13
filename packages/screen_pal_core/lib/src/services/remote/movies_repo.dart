import 'package:screen_pal_core/src/entities.dart';

/// Everything you need to manage movies.
abstract interface class MoviesRepo {
  Future<List<Movie>> getNowPlayingMovies();
  Future<List<Movie>> getPopularMovies();
  Future<List<Movie>> getTopRatedMovies();
  Future<List<Movie>> getUpcomingMovies();
  Future<List<Movie>> getRecommendations(int movieId);

  Future<MovieDetail> getMovieDetail(int movieId);
  Future<Credits> getMovieCredits(int movieId);

  Future<MovieCollectionDetail> getMovieCollectionDetail(int collectionId);
}
