import 'package:screen_pal/core/entities/genre.dart';
import 'package:screen_pal/core/entities/spoken_language.dart';

/// Extra details for the movies and tv_shows
abstract class ExtrasRepo {
  Future<List<SpokenLanguage>> getLanguages();

  Future<List<Genre>> getMovieGenres();
  Future<List<Genre>> getTvShowGenres();
}
