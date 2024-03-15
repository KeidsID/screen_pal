import 'package:screen_pal_core/src/entities.dart';
import 'package:screen_pal_core/src/services.dart';

final class GetNowPlayingMoviesCase {
  const GetNowPlayingMoviesCase({required MoviesRepo moviesRepo})
      : _moviesRepo = moviesRepo;

  final MoviesRepo _moviesRepo;

  Future<List<Movie>> execute() => _moviesRepo.getNowPlayingMovies();
}
