import 'package:screen_pal/core/entities/movie_detail.dart';
import 'package:screen_pal/core/repo/movies_repo.dart';

class GetMovieDetail {
  final MoviesRepo moviesRepo;

  GetMovieDetail({required this.moviesRepo});

  Future<MovieDetail> execute(int id) => moviesRepo.getMovieDetail(id);
}
