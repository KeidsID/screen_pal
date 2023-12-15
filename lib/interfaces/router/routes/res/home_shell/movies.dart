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

  /// Provide [Movie.id].
  final String movieId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final id = int.tryParse(movieId);

    if (id == null) {
      return Scaffold(
        body: AppHttpErrorWidget(
          statusCode: 400,
          message: 'Invalid movid id. Only accepts numbers.',
          action: ElevatedButton.icon(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Go Back'),
          ),
        ),
      );
    }

    return MovieDetailView(id);
  }
}

/// {@template interfaces.router.routes.movie_collection_detail_route}
/// `movies/collections/:collectionId` route.
/// {@endtemplate}
final class MovieCollectionRoute extends GoRouteData {
  /// {@macro interfaces.router.routes.movie_collection_detail_route}
  const MovieCollectionRoute({required this.collectionId});

  /// Provide [MovieCollection.id].
  final String collectionId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final id = int.tryParse(collectionId);

    if (id == null) {
      return Scaffold(
        body: AppHttpErrorWidget(
          statusCode: 400,
          message: 'Invalid collection id. Only accepts numbers.',
          action: ElevatedButton.icon(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Go Back'),
          ),
        ),
      );
    }

    return MovieCollectionDetailView(id);
  }
}
