import 'package:screen_pal/core/entities/movie.dart';
import 'package:screen_pal/core/repo/movie_repo.dart';

class GetPopularMovies {
  final MovieRepo movieRepo;

  GetPopularMovies({required this.movieRepo});

  Future<List<Movie>> execute() => movieRepo.getPopularMovies();
}
