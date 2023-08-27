import 'package:screen_pal/core/entities/movie.dart';
import 'package:screen_pal/core/repo/movies_repo.dart';

class GetPopularMovies {
  final MoviesRepo movieRepo;

  GetPopularMovies({required this.movieRepo});

  Future<List<Movie>> execute() => movieRepo.getPopularMovies();
}
