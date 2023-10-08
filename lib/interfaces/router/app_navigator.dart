// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Used for navigation only.
abstract final class AppNavigator {
  // base paths

  static const _moviesPath = '/movies';
  static const _tvShowsPath = '/tv_shows';
  static const _settingsPath = '/settings';

  /// Navigate to `/movies` route.
  static void movies(BuildContext context) => context.go(_moviesPath);

  /// Navigate to `/movies/movie-:movieId` route.
  static void movieDetail(BuildContext context, int movieId) {
    context.go('$_moviesPath/movie-$movieId');
  }

  /// Navigate to `/movies/movie-collection:movieCollectionId` route.
  static void movieCollection(BuildContext context, int movieCollectionId) {
    context.go('$_moviesPath/collections/movie-collection-$movieCollectionId');
  }

  /// Navigate to `/tv_shows` route.
  static void tvShows(BuildContext context) => context.go(_tvShowsPath);

  /// Navigate to `/tv_shows/tv-:tvShowId` route.
  static void tvShowDetail(BuildContext context, int tvShowId) {
    context.go('$_tvShowsPath/tv-$tvShowId');
  }

  /// Navigate to `/settings` route.
  static void settings(BuildContext context) => context.go(_settingsPath);

  /// Navigate to `/settings/about-app` route.
  static void aboutApp(BuildContext context) =>
      context.go('$_settingsPath/about-app');

  /// Navigate to `/settings/about-tmdb` route.
  static void aboutTmdb(BuildContext context) =>
      context.go('$_settingsPath/about-tmdb');
}
