import 'package:screen_pal_core/src/entities.dart';
import 'package:screen_pal_core/src/services.dart';

final class GetMovieDetailCase {
  const GetMovieDetailCase({required MoviesRepo moviesRepo})
      : _moviesRepo = moviesRepo;

  final MoviesRepo _moviesRepo;

  Future<MovieDetail> execute(int movieId) {
    return _moviesRepo.getMovieDetail(movieId);
  }
}
