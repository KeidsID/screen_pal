import '../../entities/movie.dart';
import '../../repo/movie_repo.dart';

class GetTopRatedMovies {
  final MovieRepo movieRepo;

  GetTopRatedMovies({required this.movieRepo});

  Future<List<Movie>> execute() => movieRepo.getTopRatedMovies();
}
