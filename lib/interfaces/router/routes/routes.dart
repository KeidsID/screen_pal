// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:screen_pal/interfaces/router/routes/utils/dialog_page.dart';
import 'package:screen_pal/interfaces/router/routes/utils/invalid_route_exception_view.dart';
import 'package:screen_pal/interfaces/views.dart';
import 'package:screen_pal_core/screen_pal_core.dart';

part 'res/home_shell/movies.dart';
part 'res/home_shell/settings.dart';
part 'res/home_shell/tv_shows.dart';
part 'routes.g.dart';

final routerNavKey = GlobalKey<NavigatorState>(debugLabel: 'router');
final homeShellNavKey =
    GlobalKey<NavigatorState>(debugLabel: 'home-shell-route');

/// {@template interfaces.router.routes.RefreshRoute}
/// `/` route.
/// {@endtemplate}
@TypedGoRoute<RootRoute>(path: '/')
final class RootRoute extends GoRouteData {
  /// {@macro interfaces.router.routes.RefreshRoute}
  const RootRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RestartAppView();
  }
}

/// Shell route for `/movies`, `/tv-shows` and `/settings` routes.
@TypedShellRoute<HomeShellRoute>(
  routes: [
    TypedGoRoute<MoviesRoute>(
      path: '/movies',
      routes: [
        TypedGoRoute<MovieDetailRoute>(
          path: ':movieId',
          routes: [TypedGoRoute<MovieCreditsRoute>(path: 'credits')],
        ),
        TypedGoRoute<MovieCollectionRoute>(path: 'collections/:collectionId')
      ],
    ),

    //
    TypedGoRoute<TvShowsRoute>(
      path: '/tv-shows',
      routes: [
        TypedGoRoute<TvShowDetailRoute>(
          path: ':tvShowId',
          routes: [TypedGoRoute<TvShowCreditsRoute>(path: 'credits')],
        ),
      ],
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
