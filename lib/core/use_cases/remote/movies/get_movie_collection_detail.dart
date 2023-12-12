import 'package:screen_pal/core/entities/movies/movie_collection_detail.dart';
import 'package:screen_pal/core/services/remote/movies_repo.dart';

final class GetMovieCollectionDetail {
  const GetMovieCollectionDetail({required MoviesRepo moviesRepo})
      : _moviesRepo = moviesRepo;

  final MoviesRepo _moviesRepo;

  Future<MovieCollectionDetail> execute(int collectionId) {
    return _moviesRepo.getMovieCollectionDetail(collectionId);
  }
}
