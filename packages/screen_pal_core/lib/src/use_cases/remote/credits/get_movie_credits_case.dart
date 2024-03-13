import 'package:screen_pal_core/src/entities.dart';
import 'package:screen_pal_core/src/services.dart';

final class GetMovieCreditsCase {
  final MoviesRepo _moviesRepo;

  const GetMovieCreditsCase({required MoviesRepo moviesRepo})
      : _moviesRepo = moviesRepo;

  Future<Credits> execute(int movieId) => _moviesRepo.getMovieCredits(movieId);
}
