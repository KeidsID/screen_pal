// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:screen_pal/core/entities.dart';
import 'package:screen_pal/interfaces/router/routes/utils/dialog_page.dart';
import 'package:screen_pal/interfaces/views.dart';
import 'package:screen_pal/interfaces/widgets.dart';

part 'res/home_shell/movies.dart';
part 'res/home_shell/tv_shows.dart';
part 'res/home_shell/settings.dart';
part 'routes.g.dart';

final GlobalKey<NavigatorState> routerNavKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> homeShellNavKey = GlobalKey<NavigatorState>();

/// Shell route for `/movies`, `/tv-shows` and `/settings` routes.
@TypedShellRoute<HomeShellRoute>(
  routes: [
    TypedGoRoute<MoviesRoute>(
      path: '/movies',
      routes: [
        TypedGoRoute<MovieDetailRoute>(path: ':movieId'),
        TypedGoRoute<MovieCollectionRoute>(path: 'collections/:collectionId')
      ],
    ),

    //
    TypedGoRoute<TvShowsRoute>(
      path: '/tv-shows',
      routes: [TypedGoRoute<TvShowDetailRoute>(path: ':tvShowId')],
    ),

    //
    TypedGoRoute<SettingsRoute>(
      path: '/settings',
      routes: [
        TypedGoRoute<AboutAppRoute>(
          path: 'about-app',
          routes: [
            TypedGoRoute<PrivacyPolicyRoute>(path: 'privacy-policy'),
            TypedGoRoute<TermsOfUseRoute>(path: 'terms-of-use'),
          ],
        ),

        //
        TypedGoRoute<AboutTmdbRoute>(path: 'about-tmdb'),
      ],
    ),
  ],
)
class HomeShellRoute extends ShellRouteData {
  const HomeShellRoute();

  static final GlobalKey<NavigatorState> $navigatorKey = homeShellNavKey;

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return HomeViewLayout(child: navigator);
  }
}
