import 'package:screen_pal/core/entities/movies/movie.dart';
import 'package:screen_pal/core/repo/movies_repo.dart';

class GetUpcomingMovies {
  final MoviesRepo moviesRepo;

  GetUpcomingMovies({required this.moviesRepo});

  Future<List<Movie>> execute() => moviesRepo.getUpcomingMovies();
}
