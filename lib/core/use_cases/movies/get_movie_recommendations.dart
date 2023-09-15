import 'package:screen_pal/core/entities/movies/movie.dart';
import 'package:screen_pal/core/repo/movies_repo.dart';

class GetMovieRecommendations {
  final MoviesRepo moviesRepo;

  GetMovieRecommendations({required this.moviesRepo});

  Future<List<Movie>> execute(int id) => moviesRepo.getRecommendations(id);
}
