part of '../../routes.dart';

/// {@template lib.interfaces.router.routes.MoviesRoute}
/// `/movies` route.
/// {@endtemplate}
final class MoviesRoute extends GoRouteData {
  /// {@macro lib.interfaces.router.routes.MoviesRoute}
  const MoviesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MoviesHomeView();
  }
}

/// {@template lib.interfaces.router.routes.MovieDetailRoute}
/// `movies/:movieId` route.
/// {@endtemplate}
final class MovieDetailRoute extends GoRouteData {
  /// {@macro lib.interfaces.router.routes.MovieDetailRoute}
  const MovieDetailRoute({required this.movieId});

  /// Provide [Movie.id].
  final String movieId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final id = int.tryParse(movieId);

    if (id == null) {
      return const InvalidRouteExceptionView(
        message: 'Invalid movid id. Only accepts numbers.',
      );
    }

    return MovieDetailView(id);
  }
}

/// {@template lib.interfaces.router.routes.MovieCreditsRoute}
/// `movies/:movieId/credits` route.
/// {@endtemplate}
final class MovieCreditsRoute extends GoRouteData {
  /// {@macro lib.interfaces.router.routes.MovieCreditsRoute}
  const MovieCreditsRoute({required this.movieId});

  /// Provide [MovieDetail.id].
  final String movieId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final id = int.tryParse(movieId);

    if (id == null) {
      return const InvalidRouteExceptionView(
        message: 'Invalid movid id. Only accepts numbers.',
      );
    }

    return MovieCreditsView(id);
  }
}

/// {@template lib.interfaces.router.routes.MovieCollectionRoute}
/// `movies/collections/:collectionId` route.
/// {@endtemplate}
final class MovieCollectionRoute extends GoRouteData {
  /// {@macro lib.interfaces.router.routes.MovieCollectionRoute}
  const MovieCollectionRoute({required this.collectionId});

  /// Provide [MovieCollection.id].
  final String collectionId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final id = int.tryParse(collectionId);

    if (id == null) {
      return const InvalidRouteExceptionView(
        message: 'Invalid collection id. Only accepts numbers.',
      );
    }

    return MovieCollectionDetailView(id);
  }
}
