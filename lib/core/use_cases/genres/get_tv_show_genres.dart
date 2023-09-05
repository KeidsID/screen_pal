import 'package:screen_pal/core/entities/genre.dart';
import 'package:screen_pal/core/repo/genres_repo.dart';

class GetTvShowGenres {
  final GenresRepo genresRepo;

  GetTvShowGenres({required this.genresRepo});

  Future<List<Genre>> execute() => genresRepo.getTvShowGenres();
}
