import 'package:screen_pal/core/entities/movie.dart';
import 'package:screen_pal/core/repo/movies_repo.dart';

class GetUpcomingMovies {
  final MoviesRepo movieRepo;

  GetUpcomingMovies({required this.movieRepo});

  Future<List<Movie>> execute() => movieRepo.getUpcomingMovies();
}
