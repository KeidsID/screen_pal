import 'package:screen_pal/core/entities/movie.dart';
import 'package:screen_pal/core/repo/movies_repo.dart';

class GetNowPlayingMovies {
  final MoviesRepo movieRepo;

  GetNowPlayingMovies({required this.movieRepo});

  Future<List<Movie>> execute() => movieRepo.getNowPlayingMovies();
}
