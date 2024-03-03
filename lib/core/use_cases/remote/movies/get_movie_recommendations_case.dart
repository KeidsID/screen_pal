import 'package:screen_pal/core/entities/movies/movie.dart';
import 'package:screen_pal/core/services/remote/movies_repo.dart';

final class GetMovieRecommendationsCase {
  const GetMovieRecommendationsCase({required MoviesRepo moviesRepo})
      : _moviesRepo = moviesRepo;

  final MoviesRepo _moviesRepo;

  Future<List<Movie>> execute(int movieId) {
    return _moviesRepo.getRecommendations(movieId);
  }
}