import 'package:screen_pal/core/entities/movies/movie_collection_detail.dart';
import 'package:screen_pal/core/repo/movies_repo.dart';

class GetMovieCollectionDetail {
  final MoviesRepo moviesRepo;

  GetMovieCollectionDetail({required this.moviesRepo});

  Future<MovieCollectionDetail> execute(int collectionId) {
    return moviesRepo.getMovieCollectionDetail(collectionId);
  }
}
