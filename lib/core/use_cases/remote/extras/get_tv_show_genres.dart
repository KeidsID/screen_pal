import 'package:screen_pal/core/entities/extras/genre.dart';
import 'package:screen_pal/core/services/remote/extras_repo.dart';

final class GetTvShowGenres {
  const GetTvShowGenres({required ExtrasRepo extrasRepo})
      : _extrasRepo = extrasRepo;

  final ExtrasRepo _extrasRepo;

  Future<List<Genre>> execute() => _extrasRepo.getTvShowGenres();
}
