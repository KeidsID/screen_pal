part of '../../routes.dart';

/// {@template lib.interfaces.router.routes.TvShowsRoute}
/// `/tv-shows` route.
/// {@endtemplate}
final class TvShowsRoute extends GoRouteData {
  /// {@macro lib.interfaces.router.routes.TvShowsRoute}
  const TvShowsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TvShowsHomeView();
  }
}

/// {@template lib.interfaces.router.routes.TvShowDetailRoute}
/// `tv-shows/:tvShowId` route.
/// {@endtemplate}
final class TvShowDetailRoute extends GoRouteData {
  /// {@macro lib.interfaces.router.routes.TvShowDetailRoute}
  const TvShowDetailRoute({required this.tvShowId});

  /// Provide [TvShow.id].
  final String tvShowId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final id = int.tryParse(tvShowId);

    if (id == null) {
      return const InvalidRouteExceptionView(
        message: 'Invalid tv show id. Only accepts numbers.',
      );
    }

    return TvShowDetailView(id);
  }
}

/// {@template lib.interfaces.router.routes.TvShowCreditsRoute}
/// `tv-shows/:tvShowId/credits` route.
/// {@endtemplate}
final class TvShowCreditsRoute extends GoRouteData {
  /// {@macro lib.interfaces.router.routes.TvShowCreditsRoute}
  const TvShowCreditsRoute({required this.tvShowId});

  /// Provide [TvShowDetail.id].
  final String tvShowId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final id = int.tryParse(tvShowId);

    if (id == null) {
      return const InvalidRouteExceptionView(
        message: 'Invalid tv show id. Only accepts numbers.',
      );
    }

    return TvShowCreditsView(id);
  }
}
