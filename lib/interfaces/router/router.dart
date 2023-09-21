// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:screen_pal/configs/constants.dart';

import 'package:screen_pal/interfaces/router/utils/dialog_page.dart';
import 'package:screen_pal/interfaces/views/home_view_layout.dart';
import 'package:screen_pal/interfaces/views/movies/movie_collection_detail_view.dart';
import 'package:screen_pal/interfaces/views/movies/movie_detail_view.dart';
import 'package:screen_pal/interfaces/views/movies/movies_home_view.dart';
import 'package:screen_pal/interfaces/views/settings_view.dart';
import 'package:screen_pal/interfaces/widgets/dialogs/about_app_dialog.dart';
import 'package:screen_pal/interfaces/widgets/dialogs/about_tmdb_dialog.dart';
import 'package:screen_pal/interfaces/widgets/errors/bad_request_error_view.dart';
import 'package:screen_pal/interfaces/widgets/errors/not_found_route_view.dart';
import 'package:screen_pal/interfaces/widgets/errors/unknown_error_widget.dart';

final router = GoRouter(
  initialLocation: '/movies',
  routerNeglect: true,
  errorBuilder: (_, router) => NotFoundRouteView(routePath: router.uri.path),
  redirect: (_, router) {
    final currentRoute = router.uri.path;

    if (currentRoute == '/') return '/movies';

    return null;
  },
  routes: <RouteBase>[
    ShellRoute(
      builder: (_, __, child) => HomeViewLayout(child: child),
      routes: [
        GoRoute(
          path: '/movies',
          builder: (_, __) => const MoviesHomeView(),
          routes: [
            GoRoute(
              path: 'movie-:id',
              builder: (context, router) {
                try {
                  final movieId = int.parse(router.pathParameters['id'] ?? '0');

                  return MovieDetailView(movieId);
                } catch (e) {
                  if (e is FormatException) {
                    return BadRequestErrorView(
                      message: 'Invalid path format. '
                          'Valid movie id are numbers '
                          '(ex: "/movie-123").',
                      action: ElevatedButton.icon(
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Go Back'),
                      ),
                    );
                  }

                  kLogger.f('GoRouter (${router.uri.path}) builder', error: e);

                  return const UnknownErrorWidget();
                }
              },
            ),
            GoRoute(
              path: 'collections/movie-collection-:id',
              builder: (context, router) {
                try {
                  final collectionId =
                      int.parse(router.pathParameters['id'] ?? '0');

                  return MovieCollectionDetailView(collectionId);
                } catch (e) {
                  if (e is FormatException) {
                    return BadRequestErrorView(
                      message: 'Invalid path format. '
                          'Valid movie collection id are numbers '
                          '(ex: "/movie-collection-123").',
                      action: ElevatedButton.icon(
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Go Back'),
                      ),
                    );
                  }

                  kLogger.f('GoRouter (${router.uri.path}) builder', error: e);

                  return const UnknownErrorWidget();
                }
              },
            ),
          ],
        ),
        GoRoute(
          path: '/tv_shows',
          builder: (_, __) => const Scaffold(
            body: Center(
              child: Text('Coming Soon'),
            ),
          ),
        )
      ],
    ),
    GoRoute(
      path: '/settings',
      builder: (_, __) => const SettingsView(),
      routes: [
        GoRoute(
          path: 'about-app',
          pageBuilder: (_, __) {
            return DialogPage(builder: (_) => const AboutAppDialog());
          },
        ),
        GoRoute(
          path: 'about-tmdb',
          pageBuilder: (_, __) {
            return DialogPage(builder: (_) => const AboutTmdbDialog());
          },
        ),
      ],
    ),
  ],
);
