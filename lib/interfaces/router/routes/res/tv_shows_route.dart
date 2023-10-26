// coverage:ignore-file

part of '../routes.dart';

final _tvShowsRoute = GoRoute(
  path: '/tv-shows',
  builder: (_, __) => const TvShowsHomeView(),
  routes: [
    GoRoute(path: 'tv-:id', builder: _tvShowDetailBuilder),
  ],
);

Widget _tvShowDetailBuilder(BuildContext context, GoRouterState router) {
  try {
    final tvShowId = int.parse(router.pathParameters['id'] ?? '0');

    return TvShowDetailView(tvShowId);
  } catch (e) {
    if (e is FormatException) {
      return Scaffold(
        body: AppHttpErrorWidget(
          statusCode: 400,
          message: 'Invalid path format. '
              'Valid tv show id are numbers with "tv-" as prefix '
              '(ex: "/tv-123").',
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
