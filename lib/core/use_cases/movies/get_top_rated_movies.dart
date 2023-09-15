import 'package:screen_pal/core/entities/movies/movie.dart';
import 'package:screen_pal/core/repo/movies_repo.dart';

class GetTopRatedMovies {
  final MoviesRepo moviesRepo;

  GetTopRatedMovies({required this.moviesRepo});

  Future<List<Movie>> execute() => moviesRepo.getTopRatedMovies();
}
