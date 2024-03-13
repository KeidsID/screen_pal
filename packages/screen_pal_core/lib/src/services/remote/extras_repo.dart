import 'package:screen_pal_core/src/entities.dart';

/// Extra details for the movies and tv_shows
abstract interface class ExtrasRepo {
  Future<List<SpokenLanguage>> getLanguages();

  Future<List<Genre>> getMovieGenres();
  Future<List<Genre>> getTvShowGenres();
}
