// coverage:ignore-file

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:screen_pal/core/entities/genre.dart';
import 'package:screen_pal/core/use_cases/extras/get_movie_genres.dart';
import 'package:screen_pal/core/use_cases/extras/get_tv_show_genres.dart';
import 'package:screen_pal/configs/service_locator/locator.dart' as service;

part 'genres_providers.g.dart';

@Riverpod(keepAlive: true, dependencies: [])
class MovieGenres extends _$MovieGenres {
  @override
  List<Genre> build() {
    _init();

    return [];
  }

  Future<void> _init() async {
    try {
      state = await service.locator<GetMovieGenres>().execute();
    } catch (e) {
      state = [];
    }
  }
}

@Riverpod(keepAlive: true, dependencies: [])
class TvShowGenres extends _$TvShowGenres {
  @override
  List<Genre> build() {
    _init();

    return [];
  }

  Future<void> _init() async {
    try {
      state = await service.locator<GetTvShowGenres>().execute();
    } catch (e) {
      state = [];
    }
  }
}
