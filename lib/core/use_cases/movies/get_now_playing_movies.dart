import 'package:screen_pal/core/entities/movies/movie.dart';
import 'package:screen_pal/core/repo/movies_repo.dart';

class GetNowPlayingMovies {
  final MoviesRepo moviesRepo;

  GetNowPlayingMovies({required this.moviesRepo});

  Future<List<Movie>> execute() => moviesRepo.getNowPlayingMovies();
}
