import 'package:screen_pal/core/entities/movie.dart';
import 'package:screen_pal/core/repo/movie_repo.dart';

class GetTopRatedMovies {
  final MovieRepo movieRepo;

  GetTopRatedMovies({required this.movieRepo});

  Future<List<Movie>> execute() => movieRepo.getTopRatedMovies();
}
