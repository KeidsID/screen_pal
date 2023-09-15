// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Used for navigation only.
abstract final class AppNavigator {
  /// Navigate to `/movies` route.
  static void movies(BuildContext context) => context.go('/movies');

  /// Navigate to `/movies/:movieId` route.
  static void moviesDetail(BuildContext context, int movieId) {
    context.go('/movies/movie-$movieId');
  }

  /// Navigate to `/tv_shows` route.
  static void tvShows(BuildContext context) => context.go('/tv_shows');

  /// Navigate to `/settings` route.
  static void settings(BuildContext context) => context.go('/settings');
}
