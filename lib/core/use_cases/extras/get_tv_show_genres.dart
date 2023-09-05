import 'package:screen_pal/core/entities/genre.dart';
import 'package:screen_pal/core/repo/extras_repo.dart';

class GetTvShowGenres {
  final ExtrasRepo extrasRepo;

  GetTvShowGenres({required this.extrasRepo});

  Future<List<Genre>> execute() => extrasRepo.getTvShowGenres();
}
