import 'package:screen_pal/core/entities/movies/movie.dart';
import 'package:screen_pal/core/services/remote/movies_repo.dart';

final class GetTopRatedMoviesCase {
  const GetTopRatedMoviesCase({required MoviesRepo moviesRepo})
      : _moviesRepo = moviesRepo;

  final MoviesRepo _moviesRepo;

  Future<List<Movie>> execute() => _moviesRepo.getTopRatedMovies();
}
