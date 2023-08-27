import 'package:screen_pal/core/entities/movie.dart';
import 'package:screen_pal/core/repo/movies_repo.dart';

class GetTopRatedMovies {
  final MoviesRepo movieRepo;

  GetTopRatedMovies({required this.movieRepo});

  Future<List<Movie>> execute() => movieRepo.getTopRatedMovies();
}
