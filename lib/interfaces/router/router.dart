import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:screen_pal/interfaces/pages/home_layout.dart';
import 'package:screen_pal/interfaces/pages/movies/movies_home_page.dart';
import 'package:screen_pal/interfaces/pages/settings_page.dart';
import 'package:screen_pal/interfaces/widgets/errors/not_found_route_page.dart';

final router = GoRouter(
  initialLocation: '/movies',
  routerNeglect: true,
  errorBuilder: (_, state) => NotFoundRoutePage(routePath: state.uri.path),
  redirect: (context, state) {
    final currentRoute = state.uri.path;

    if (currentRoute == '/') return '/movies';

    return null;
  },
  routes: [
    ShellRoute(
      builder: (_, __, child) {
        return HomeLayout(child: child);
      },
      routes: [
        GoRoute(
          path: '/movies',
          builder: (_, __) => const MoviesHomePage(),
        ),
        GoRoute(
          path: '/series',
          builder: (_, __) => const Scaffold(
            body: Center(
              child: Text('Series Page'),
            ),
          ),
        )
      ],
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
    ),
  ],
);
