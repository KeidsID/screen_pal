import 'package:screen_pal_core/src/entities.dart';
import 'package:screen_pal_core/src/services.dart';

final class GetTvShowGenresCase {
  const GetTvShowGenresCase({required ExtrasRepo extrasRepo})
      : _extrasRepo = extrasRepo;

  final ExtrasRepo _extrasRepo;

  Future<List<Genre>> execute() => _extrasRepo.getTvShowGenres();
}
