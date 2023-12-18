part of '../../routes.dart';

/// {@template interfaces.router.routes.tv_shows_route}
/// `/tv-shows` route.
/// {@endtemplate}
final class TvShowsRoute extends GoRouteData {
  /// {@macro interfaces.router.routes.tv_shows_route}
  const TvShowsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TvShowsHomeView();
  }
}

/// {@template interfaces.router.routes.tv_show_detail_route}
/// `tv-shows/:tvShowId` route.
/// {@endtemplate}
final class TvShowDetailRoute extends GoRouteData {
  /// {@macro interfaces.router.routes.tv_show_detail_route}
  const TvShowDetailRoute({required this.tvShowId});

  /// Provide [TvShow.id].
  final String tvShowId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final id = int.tryParse(tvShowId);

    if (id == null) {
      return Scaffold(
        body: SizedExceptionWidget(
          BasicHttpException(
            statusCode: 400,
            message: 'Invalid tv show id. Only accepts numbers.',
          ),
          action: ElevatedButton.icon(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Go Back'),
          ),
        ),
      );
    }

    return TvShowDetailView(id);
  }
}
