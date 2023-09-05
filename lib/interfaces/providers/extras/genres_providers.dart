import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:screen_pal/core/entities/genre.dart';
import 'package:screen_pal/core/use_cases/extras/get_movie_genres.dart';
import 'package:screen_pal/core/use_cases/extras/get_tv_show_genres.dart';
import 'package:screen_pal/service_locator/locator.dart';

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
      state = await locator<GetMovieGenres>().execute();
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
      state = await locator<GetTvShowGenres>().execute();
    } catch (e) {
      state = [];
    }
  }
}
