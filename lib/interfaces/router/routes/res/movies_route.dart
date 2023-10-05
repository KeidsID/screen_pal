// coverage:ignore-file

part of '../routes.dart';

final _moviesRoute = GoRoute(
  path: '/movies',
  builder: (_, __) => const MoviesHomeView(),
  routes: [
    GoRoute(path: 'movie-:id', builder: _movieDetailBuilder),
    GoRoute(
      path: 'collections/movie-collection-:id',
      builder: _movieCollectionDetailBuilder,
    ),
  ],
);

Widget _movieDetailBuilder(BuildContext context, GoRouterState router) {
  try {
    final movieId = int.parse(router.pathParameters['id'] ?? '0');

    return MovieDetailView(movieId);
  } catch (e) {
    if (e is FormatException) {
      return Scaffold(
        body: AppHttpErrorWidget(
          statusCode: 400,
          message: 'Invalid path format. '
              'Valid movie id are numbers (ex: "/movie-123").',
          action: ElevatedButton.icon(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Go Back'),
          ),
        ),
      );
    }

    kLogger.f('GoRouter (${router.uri.path}) builder', error: e);

    return const Scaffold(body: AppErrorWidget());
  }
}

Widget _movieCollectionDetailBuilder(
  BuildContext context,
  GoRouterState router,
) {
  try {
    final collectionId = int.parse(router.pathParameters['id'] ?? '0');

    return MovieCollectionDetailView(collectionId);
  } catch (e) {
    if (e is FormatException) {
      return Scaffold(
        body: AppHttpErrorWidget(
          statusCode: 400,
          message: 'Invalid path format. '
              'Valid movie collection id are numbers '
              '(ex: "/movie-collection-123").',
          action: ElevatedButton.icon(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Go Back'),
          ),
        ),
      );
    }

    kLogger.f('GoRouter (${router.uri.path}) builder', error: e);

    return const Scaffold(body: AppErrorWidget());
  }
}
