import '../../entities/movie.dart';
import '../../repo/movie_repo.dart';

class GetNowPlayingMovies {
  final MovieRepo movieRepo;

  GetNowPlayingMovies({required this.movieRepo});

  Future<List<Movie>> execute() => movieRepo.getNowPlayingMovies();
}
