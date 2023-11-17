import 'package:screen_pal/core/entities/credits/credits.dart';
import 'package:screen_pal/core/repo/movies_repo.dart';

final class GetMovieCredits {
  final MoviesRepo _moviesRepo;

  const GetMovieCredits({required MoviesRepo moviesRepo})
      : _moviesRepo = moviesRepo;

  Future<Credits> execute(int movieId) => _moviesRepo.getMovieCredits(movieId);
}
