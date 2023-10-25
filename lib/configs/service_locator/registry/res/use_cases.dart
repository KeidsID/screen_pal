// coverage:ignore-file

part of '../registry.dart';

void registerUseCases() {
  // apps
  locator.registerLazySingleton(() => GetThemeMode(appSettingsRepo: locator()));
  locator.registerLazySingleton(() => SetThemeMode(appSettingsRepo: locator()));

  // extras
  locator.registerLazySingleton(() => GetLanguages(extrasRepo: locator()));
  locator.registerLazySingleton(() => GetMovieGenres(extrasRepo: locator()));
  locator.registerLazySingleton(() => GetTvShowGenres(extrasRepo: locator()));

  // movies
  locator.registerLazySingleton(() {
    return GetNowPlayingMovies(moviesRepo: locator());
  });
  locator.registerLazySingleton(() => GetPopularMovies(moviesRepo: locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(moviesRepo: locator()));
  locator.registerLazySingleton(() => GetUpcomingMovies(moviesRepo: locator()));
  locator.registerLazySingleton(() => GetMovieDetail(moviesRepo: locator()));
  locator.registerLazySingleton(() {
    return GetMovieRecommendations(moviesRepo: locator());
  });
  locator.registerLazySingleton(() {
    return GetMovieCollectionDetail(moviesRepo: locator());
  });

  // tv_shows
  locator.registerLazySingleton(() {
    return GetAiringTodayTvShows(tvShowsRepo: locator());
  });
  locator.registerLazySingleton(() => GetOnAirTvShows(tvShowsRepo: locator()));
  locator.registerLazySingleton(() {
    return GetPopularTvShows(tvShowsRepo: locator());
  });
  locator.registerLazySingleton(() {
    return GetTopRatedTvShows(tvShowsRepo: locator());
  });

  locator.registerLazySingleton(() => GetTvShowDetail(tvShowsRepo: locator()));
}
