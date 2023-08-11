import '../../entities/movie.dart';
import '../../repo/movie_repo.dart';

class GetPopularMovies {
  final MovieRepo movieRepo;

  GetPopularMovies({required this.movieRepo});

  Future<List<Movie>> execute() => movieRepo.getPopularMovies();
}
