import 'package:screen_pal_core/src/entities.dart';
import 'package:screen_pal_core/src/services.dart';

final class GetTopRatedMoviesCase {
  const GetTopRatedMoviesCase({required MoviesRepo moviesRepo})
      : _moviesRepo = moviesRepo;

  final MoviesRepo _moviesRepo;

  Future<List<Movie>> execute() => _moviesRepo.getTopRatedMovies();
}
