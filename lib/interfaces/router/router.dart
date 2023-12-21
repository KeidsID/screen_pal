// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:screen_pal/core/entities.dart';
import 'package:screen_pal/interfaces/providers/remote/extras/extras_providers.dart';
import 'package:screen_pal/interfaces/router/routes/routes.dart';
import 'package:screen_pal/interfaces/widgets.dart';

part 'router.g.dart';

@Riverpod(keepAlive: true, dependencies: [extrasDependenciesState])
GoRouter router(RouterRef ref) {
  final extrasHasEmptyNotifier = ValueNotifier<bool>(true);

  ref
    ..onDispose(extrasHasEmptyNotifier.dispose)
    ..listen(extrasDependenciesStateProvider, (_, next) {
      extrasHasEmptyNotifier.value = !next.hasValue;
    });

  final router = GoRouter(
    navigatorKey: routerNavKey,
    debugLogDiagnostics: true,
    refreshListenable: extrasHasEmptyNotifier,
    initialLocation: const RootRoute().location,
    routes: $appRoutes,
    errorBuilder: (context, router) {
      return Scaffold(
        body: SizedExceptionWidget.expand(
          BasicHttpException(
            statusCode: 404,
            message: 'No resource found on "${router.uri.path}" path.',
          ),
          action: ElevatedButton.icon(
            onPressed: () => const MoviesRoute().go(context),
            icon: const Icon(Icons.home),
            label: const Text('Back to Home'),
          ),
        ),
      );
    },
    redirect: (_, router) {
      final currentRoute = router.uri.path;

      final isRootRoute = currentRoute == const RootRoute().location;

      if (extrasHasEmptyNotifier.value) {
        if (isRootRoute) return null;

        return const RootRoute().location;
      }

      if (isRootRoute) return const MoviesRoute().location;

      return null;
    },
  );
  ref.onDispose(router.dispose);

  return router;
}
