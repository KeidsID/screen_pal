// coverage:ignore-file

part of '../registry.dart';

void registerUseCases() {
  locator.registerLazySingleton(() {
    return GetThemeMode(appSettingsRepo: locator());
  });
  locator.registerLazySingleton(() {
    return SetThemeMode(appSettingsRepo: locator());
  });

  locator.registerLazySingleton(() {
    return GetLanguages(extrasRepo: locator());
  });
  locator.registerLazySingleton(() {
    return GetMovieGenres(extrasRepo: locator());
  });
  locator.registerLazySingleton(() {
    return GetTvShowGenres(extrasRepo: locator());
  });

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
  locator.registerLazySingleton(() {
    return GetMovieDetail(moviesRepo: locator());
  });
  locator.registerLazySingleton(() {
    return GetMovieRecommendations(moviesRepo: locator());
  });
  locator.registerLazySingleton(() {
    return GetMovieCollectionDetail(moviesRepo: locator());
  });
}
