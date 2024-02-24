import 'package:screen_pal/core/entities/credits/credits.dart';
import 'package:screen_pal/core/services/remote/movies_repo.dart';

final class GetMovieCreditsCase {
  final MoviesRepo _moviesRepo;

  const GetMovieCreditsCase({required MoviesRepo moviesRepo})
      : _moviesRepo = moviesRepo;

  Future<Credits> execute(int movieId) => _moviesRepo.getMovieCredits(movieId);
}
