// coverage:ignore-file

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:screen_pal/infrastructures/container/container.dart' as service;
import 'package:screen_pal_core/screen_pal_core.dart';

part 'genres_providers.g.dart';

@Riverpod(keepAlive: true, dependencies: [])
Future<List<Genre>> movieGenres(MovieGenresRef ref) {
  return service.locator<GetMovieGenresCase>().execute();
}

@Riverpod(keepAlive: true, dependencies: [])
Future<List<Genre>> tvShowGenres(TvShowGenresRef ref) {
  return service.locator<GetTvShowGenresCase>().execute();
}
