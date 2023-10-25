import 'package:screen_pal/core/entities/extras/genre.dart';
import 'package:screen_pal/core/repo/extras_repo.dart';

final class GetMovieGenres {
  const GetMovieGenres({required ExtrasRepo extrasRepo})
      : _extrasRepo = extrasRepo;

  final ExtrasRepo _extrasRepo;

  Future<List<Genre>> execute() => _extrasRepo.getMovieGenres();
}
