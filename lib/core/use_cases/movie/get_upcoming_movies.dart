import '../../entities/movie.dart';
import '../../repo/movie_repo.dart';

class GetUpcomingMovies {
  final MovieRepo movieRepo;

  GetUpcomingMovies({required this.movieRepo});

  Future<List<Movie>> execute() => movieRepo.getUpcomingMovies();
}
