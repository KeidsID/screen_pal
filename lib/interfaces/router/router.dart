// coverage:ignore-file

import 'package:go_router/go_router.dart';

import 'package:screen_pal/interfaces/widgets/errors/not_found_route_view.dart';

import 'routes/routes.dart';

final router = GoRouter(
  initialLocation: '/movies',
  routerNeglect: true,
  errorBuilder: (_, router) => NotFoundRouteView(routePath: router.uri.path),
  redirect: (_, router) {
    final currentRoute = router.uri.path;

    if (currentRoute == '/') return '/movies';

    return null;
  },
  routes: routes,
);
