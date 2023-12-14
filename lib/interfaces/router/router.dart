// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:screen_pal/interfaces/router/routes/routes.dart';
import 'package:screen_pal/interfaces/widgets/errors/app_http_error_widget.dart';

final router = GoRouter(
  initialLocation: '/movies',
  routes: $appRoutes,
  errorBuilder: (context, router) {
    return Scaffold(
      body: AppHttpErrorWidget(
        statusCode: 404,
        message: 'No resource found on "${router.uri.path}" path.',
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

    if (currentRoute == '/') return '/movies';

    return null;
  },
);
