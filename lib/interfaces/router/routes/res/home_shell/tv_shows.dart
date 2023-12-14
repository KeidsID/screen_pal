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

  final int tvShowId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TvShowDetailView(tvShowId);
  }
}
