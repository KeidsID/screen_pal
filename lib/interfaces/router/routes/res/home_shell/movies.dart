part of '../../routes.dart';

/// {@template interfaces.router.routes.movies_route}
/// `/movies` route.
/// {@endtemplate}
final class MoviesRoute extends GoRouteData {
  /// {@macro interfaces.router.routes.movies_route}
  const MoviesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MoviesHomeView();
  }
}

/// {@template interfaces.router.routes.movie_detail_route}
/// `movies/:movieId` route.
/// {@endtemplate}
final class MovieDetailRoute extends GoRouteData {
  /// {@macro interfaces.router.routes.movie_detail_route}
  const MovieDetailRoute({required this.movieId});

  final int movieId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return MovieDetailView(movieId);
  }
}

/// {@template interfaces.router.routes.movie_collection_detail_route}
/// `movies/collections/:collectionId` route.
/// {@endtemplate}
final class MovieCollectionRoute extends GoRouteData {
  /// {@macro interfaces.router.routes.movie_collection_detail_route}
  const MovieCollectionRoute({required this.collectionId});

  final int collectionId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return MovieCollectionDetailView(collectionId);
  }
}
