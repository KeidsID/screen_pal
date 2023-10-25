// coverage:ignore-file

part of '../registry.dart';

void registerUseCases() {
  locator
    // apps
    ..registerLazySingleton(() => GetThemeMode(appSettingsRepo: locator()))
    ..registerLazySingleton(() => SetThemeMode(appSettingsRepo: locator()))

    // extras
    ..registerLazySingleton(() => GetLanguages(extrasRepo: locator()))
    ..registerLazySingleton(() => GetMovieGenres(extrasRepo: locator()))
    ..registerLazySingleton(() => GetTvShowGenres(extrasRepo: locator()))

    // movies
    ..registerLazySingleton(() => GetNowPlayingMovies(moviesRepo: locator()))
    ..registerLazySingleton(() => GetPopularMovies(moviesRepo: locator()))
    ..registerLazySingleton(() => GetTopRatedMovies(moviesRepo: locator()))
    ..registerLazySingleton(() => GetUpcomingMovies(moviesRepo: locator()))
    ..registerLazySingleton(() => GetMovieDetail(moviesRepo: locator()))
    ..registerLazySingleton(
        () => GetMovieRecommendations(moviesRepo: locator()))
    ..registerLazySingleton(
        () => GetMovieCollectionDetail(moviesRepo: locator()))

    // tv_shows
    ..registerLazySingleton(() => GetAiringTodayTvShows(tvShowsRepo: locator()))
    ..registerLazySingleton(() => GetOnAirTvShows(tvShowsRepo: locator()))
    ..registerLazySingleton(() => GetPopularTvShows(tvShowsRepo: locator()))
    ..registerLazySingleton(() => GetTopRatedTvShows(tvShowsRepo: locator()))
    ..registerLazySingleton(() => GetTvShowDetail(tvShowsRepo: locator()))
    ..registerLazySingleton(
        () => GetTvShowRecommendations(tvShowsRepo: locator()));
}
