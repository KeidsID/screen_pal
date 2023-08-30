import '../../../core/use_cases/movie/get_now_playing_movies.dart';
import '../../../core/use_cases/movie/get_popular_movies.dart';
import '../../../core/use_cases/movie/get_top_rated_movies.dart';
import '../../../core/use_cases/movie/get_upcoming_movies.dart';
import '../../locator.dart';

void registerUseCases() {
  locator.registerLazySingleton(() {
    return GetNowPlayingMovies(moviesRepo: locator());
  });
  locator.registerLazySingleton(() {
    return GetPopularMovies(moviesRepo: locator());
  });
  locator.registerLazySingleton(() {
    return GetTopRatedMovies(moviesRepo: locator());
  });
  locator.registerLazySingleton(() {
    return GetUpcomingMovies(moviesRepo: locator());
  });
}
