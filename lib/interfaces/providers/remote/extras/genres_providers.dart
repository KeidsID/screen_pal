// coverage:ignore-file

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:screen_pal/infrastructures/container/container.dart' as service;
import 'package:screen_pal/core/entities/extras/genre.dart';
import 'package:screen_pal/core/use_cases/remote/extras/get_movie_genres_case.dart';
import 'package:screen_pal/core/use_cases/remote/extras/get_tv_show_genres_case.dart';

part 'genres_providers.g.dart';

@Riverpod(keepAlive: true, dependencies: [])
Future<List<Genre>> movieGenres(MovieGenresRef ref) {
  return service.locator<GetMovieGenresCase>().execute();
}

@Riverpod(keepAlive: true, dependencies: [])
Future<List<Genre>> tvShowGenres(TvShowGenresRef ref) {
  return service.locator<GetTvShowGenresCase>().execute();
}
