import 'package:go_router/go_router.dart';

import 'package:screen_pal/interfaces/pages/home_page/home_page.dart';
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
    GoRoute(
      path: '/movies',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
    ),
  ],
);
