import 'package:screen_pal/core/entities/extras/genre.dart';
import 'package:screen_pal/core/entities/extras/spoken_language.dart';

/// Extra details for the movies and tv_shows
abstract interface class ExtrasRepo {
  Future<List<SpokenLanguage>> getLanguages();

  Future<List<Genre>> getMovieGenres();
  Future<List<Genre>> getTvShowGenres();
}
