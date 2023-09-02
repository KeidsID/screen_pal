import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:screen_pal/core/entities/genre.dart';
import 'package:screen_pal/core/use_cases/genre/get_movie_genres.dart';
import 'package:screen_pal/service_locator/locator.dart';

part 'genres_providers.g.dart';

@riverpod
Future<List<Genre>> movieGenres(MovieGenresRef ref) {
  return locator<GetMovieGenres>().execute();
}

@riverpod
Future<List<Genre>> tvShowGenres(TvShowGenresRef ref) {
  return locator<GetMovieGenres>().execute();
}
