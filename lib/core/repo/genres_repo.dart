import 'package:screen_pal/core/entities/genre.dart';

abstract class GenresRepo {
  Future<List<Genre>> getMovieGenres();
  Future<List<Genre>> getTvShowGenres();
}
