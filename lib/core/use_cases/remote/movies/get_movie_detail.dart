import 'package:screen_pal/core/entities/movies/movie_detail.dart';
import 'package:screen_pal/core/services/remote/movies_repo.dart';

final class GetMovieDetail {
  const GetMovieDetail({required MoviesRepo moviesRepo})
      : _moviesRepo = moviesRepo;

  final MoviesRepo _moviesRepo;

  Future<MovieDetail> execute(int movieId) {
    return _moviesRepo.getMovieDetail(movieId);
  }
}
