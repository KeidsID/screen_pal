part of '../container.dart';

void _registerServices() {
  locator
    // cache
    ..registerSingletonAsync(() => SharedPreferences.getInstance())
    //
    ..registerLazySingleton<ThemeModeCache>(() => ThemeModeCacheImpl(locator()))

    // remote
    ..registerSingleton<Dio>(tmdbClient)
    //
    ..registerLazySingleton<ExtrasRepo>(() => ExtrasRepoImpl(locator()))
    ..registerLazySingleton<MoviesRepo>(() => MoviesRepoImpl(locator()))
    ..registerLazySingleton<TvShowsRepo>(() => TvShowsRepoImpl(locator()));
}
