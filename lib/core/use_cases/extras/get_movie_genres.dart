import 'package:screen_pal/core/entities/extras/genre.dart';
import 'package:screen_pal/core/repo/extras_repo.dart';

class GetMovieGenres {
  final ExtrasRepo extrasRepo;

  GetMovieGenres({required this.extrasRepo});

  Future<List<Genre>> execute() => extrasRepo.getMovieGenres();
}
