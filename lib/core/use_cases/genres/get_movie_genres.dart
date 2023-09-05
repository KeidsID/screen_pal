import 'package:screen_pal/core/entities/genre.dart';
import 'package:screen_pal/core/repo/genres_repo.dart';

class GetMovieGenres {
  final GenresRepo genresRepo;

  GetMovieGenres({required this.genresRepo});

  Future<List<Genre>> execute() => genresRepo.getMovieGenres();
}
