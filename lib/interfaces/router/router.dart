// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:screen_pal/interfaces/views/home_view_layout.dart';
import 'package:screen_pal/interfaces/views/movies/movie_detail_view.dart';
import 'package:screen_pal/interfaces/views/movies/movies_home_view.dart';
import 'package:screen_pal/interfaces/views/settings_view.dart';
import 'package:screen_pal/interfaces/widgets/errors/not_found_route_page.dart';

final router = GoRouter(
  initialLocation: '/movies',
  routerNeglect: true,
  errorBuilder: (_, state) => NotFoundRoutePage(routePath: state.uri.path),
  redirect: (_, state) {
    final currentRoute = state.uri.path;

    if (currentRoute == '/') return '/movies';

    return null;
  },
  routes: [
    ShellRoute(
      builder: (_, __, child) => HomeViewLayout(child: child),
      routes: [
        GoRoute(
          path: '/movies',
          builder: (_, __) => const MoviesHomeView(),
        ),
        GoRoute(
          path: '/tv_shows',
          builder: (_, __) => const Scaffold(
            body: Center(
              child: Text('Tv Shows Page'),
            ),
          ),
        )
      ],
    ),
    GoRoute(
      path: '/settings',
      builder: (_, __) => const SettingsView(),
    ),
    GoRoute(
      path: '/movies/movie-:id',
      builder: (context, router) {
        final movieId = int.parse(router.pathParameters['id'] ?? '0');

        return MovieDetailView(movieId: movieId);
      },
    ),
  ],
);
