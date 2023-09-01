// coverage:ignore-file

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:screen_pal/core/entities/movie.dart';
import 'package:screen_pal/core/use_cases/movie/get_now_playing_movies.dart';
import 'package:screen_pal/core/use_cases/movie/get_popular_movies.dart';
import 'package:screen_pal/core/use_cases/movie/get_top_rated_movies.dart';
import 'package:screen_pal/core/use_cases/movie/get_upcoming_movies.dart';
import 'package:screen_pal/service_locator/locator.dart';

part 'movie_list_providers.g.dart';

@riverpod
class NowPlayingMovies extends _$NowPlayingMovies {
  static final _getNowPlayingMovies = locator<GetNowPlayingMovies>();

  @override
  Future<List<Movie>> build() => _getNowPlayingMovies.execute();

  Future<void> reFetchMovies() async {
    state = const AsyncValue.loading();

    try {
      final movies = await _getNowPlayingMovies.execute();

      state = AsyncValue.data(movies);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

@riverpod
class PopularMovies extends _$PopularMovies {
  static final _getPopularMovies = locator<GetPopularMovies>();

  @override
  Future<List<Movie>> build() => _getPopularMovies.execute();

  Future<void> reFetchMovies() async {
    state = const AsyncValue.loading();

    try {
      final movies = await _getPopularMovies.execute();

      state = AsyncValue.data(movies);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

@riverpod
class TopRatedMovies extends _$TopRatedMovies {
  static final _getTopRatedMovies = locator<GetTopRatedMovies>();

  @override
  Future<List<Movie>> build() => _getTopRatedMovies.execute();

  Future<void> reFetchMovies() async {
    state = const AsyncValue.loading();

    try {
      final movies = await _getTopRatedMovies.execute();

      state = AsyncValue.data(movies);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

@riverpod
class UpcomingMovies extends _$UpcomingMovies {
  static final _getUpcomingMovies = locator<GetUpcomingMovies>();

  @override
  Future<List<Movie>> build() => _getUpcomingMovies.execute();

  Future<void> reFetchMovies() async {
    state = const AsyncValue.loading();

    try {
      final movies = await _getUpcomingMovies.execute();

      state = AsyncValue.data(movies);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
