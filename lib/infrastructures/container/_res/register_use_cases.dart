// coverage:ignore-file

part of '../container.dart';

void _registerUseCases() {
  // cache
  locator
    ..registerLazySingleton(() => GetThemeModeCase(themeModeCache: locator()))
    ..registerLazySingleton(() => SetThemeModeCase(themeModeCache: locator()));

  // remote
  locator
    // credits
    ..registerLazySingleton(() => GetMovieCreditsCase(moviesRepo: locator()))
    ..registerLazySingleton(() => GetTvShowCreditsCase(tvShowsRepo: locator()))
    ..registerLazySingleton(
        () => GetTvShowFullCreditsCase(tvShowsRepo: locator()))

    // extras
    ..registerLazySingleton(() => GetLanguagesCase(extrasRepo: locator()))
    ..registerLazySingleton(() => GetMovieGenresCase(extrasRepo: locator()))
    ..registerLazySingleton(() => GetTvShowGenresCase(extrasRepo: locator()))

    // movies
    ..registerLazySingleton(
        () => GetNowPlayingMoviesCase(moviesRepo: locator()))
    ..registerLazySingleton(() => GetPopularMoviesCase(moviesRepo: locator()))
    ..registerLazySingleton(() => GetTopRatedMoviesCase(moviesRepo: locator()))
    ..registerLazySingleton(() => GetUpcomingMoviesCase(moviesRepo: locator()))
    ..registerLazySingleton(() => GetMovieDetailCase(moviesRepo: locator()))
    ..registerLazySingleton(
        () => GetMovieRecommendationsCase(moviesRepo: locator()))
    ..registerLazySingleton(
        () => GetMovieCollectionDetailCase(moviesRepo: locator()))

    // tv_shows
    ..registerLazySingleton(
        () => GetAiringTodayTvShowsCase(tvShowsRepo: locator()))
    ..registerLazySingleton(() => GetOnAirTvShowsCase(tvShowsRepo: locator()))
    ..registerLazySingleton(() => GetPopularTvShowsCase(tvShowsRepo: locator()))
    ..registerLazySingleton(
        () => GetTopRatedTvShowsCase(tvShowsRepo: locator()))
    ..registerLazySingleton(() => GetTvShowDetailCase(tvShowsRepo: locator()))
    ..registerLazySingleton(
        () => GetTvShowRecommendationsCase(tvShowsRepo: locator()));
}
