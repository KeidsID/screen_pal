import 'package:screen_pal/core/entities/movies/movie_collection_detail.dart';
import 'package:screen_pal/core/services/remote/movies_repo.dart';

final class GetMovieCollectionDetailCase {
  const GetMovieCollectionDetailCase({required MoviesRepo moviesRepo})
      : _moviesRepo = moviesRepo;

  final MoviesRepo _moviesRepo;

  Future<MovieCollectionDetail> execute(int collectionId) {
    return _moviesRepo.getMovieCollectionDetail(collectionId);
  }
}
