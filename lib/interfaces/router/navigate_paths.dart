/// Used for navigation only.
abstract class NavigatePaths {
  static const movies = '/movies';
  static String moviesDetail(int movieId) => '/movies/movie-$movieId';
  static const series = '/series';
  static const settings = '/settings';
}
