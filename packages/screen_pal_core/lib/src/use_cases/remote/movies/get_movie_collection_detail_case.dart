import 'package:screen_pal_core/src/entities.dart';
import 'package:screen_pal_core/src/services.dart';

final class GetMovieCollectionDetailCase {
  const GetMovieCollectionDetailCase({required MoviesRepo moviesRepo})
      : _moviesRepo = moviesRepo;

  final MoviesRepo _moviesRepo;

  Future<MovieCollectionDetail> execute(int collectionId) {
    return _moviesRepo.getMovieCollectionDetail(collectionId);
  }
}
