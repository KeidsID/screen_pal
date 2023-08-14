import 'package:screen_pal/core/entities/movie.dart';
import 'package:screen_pal/core/repo/movie_repo.dart';

class GetNowPlayingMovies {
  final MovieRepo movieRepo;

  GetNowPlayingMovies({required this.movieRepo});

  Future<List<Movie>> execute() => movieRepo.getNowPlayingMovies();
}
