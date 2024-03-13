import 'package:screen_pal_core/src/entities.dart';
import 'package:screen_pal_core/src/services.dart';

final class GetMovieRecommendationsCase {
  const GetMovieRecommendationsCase({required MoviesRepo moviesRepo})
      : _moviesRepo = moviesRepo;

  final MoviesRepo _moviesRepo;

  Future<List<Movie>> execute(int movieId) {
    return _moviesRepo.getRecommendations(movieId);
  }
}
