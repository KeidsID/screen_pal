import 'package:screen_pal/core/entities/movie.dart';
import 'package:screen_pal/core/repo/movie_repo.dart';

class GetUpcomingMovies {
  final MovieRepo movieRepo;

  GetUpcomingMovies({required this.movieRepo});

  Future<List<Movie>> execute() => movieRepo.getUpcomingMovies();
}
