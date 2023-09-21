import 'package:screen_pal/core/entities/movies/movie_detail.dart';
import 'package:screen_pal/core/repo/movies_repo.dart';

class GetMovieDetail {
  final MoviesRepo moviesRepo;

  GetMovieDetail({required this.moviesRepo});

  Future<MovieDetail> execute(int movieId) {
    return moviesRepo.getMovieDetail(movieId);
  }
}
