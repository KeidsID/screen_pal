import 'package:screen_pal/core/entities/movie.dart';
import 'package:screen_pal/core/repo/movies_repo.dart';

class GetPopularMovies {
  final MoviesRepo moviesRepo;

  GetPopularMovies({required this.moviesRepo});

  Future<List<Movie>> execute() => moviesRepo.getPopularMovies();
}
