// coverage:ignore-file

part of '../container.dart';

void _registerServices() {
  // external
  locator
    ..registerSingletonAsync(() => PackageInfo.fromPlatform())
    ..registerSingletonAsync(() => SharedPreferences.getInstance());

  // internal
  locator
    // cache
    ..registerLazySingleton<ThemeModeCache>(() => ThemeModeCacheImpl(locator()))

    // remote
    ..registerSingleton<Dio>(tmdbClient)
    //
    ..registerLazySingleton<ExtrasRepo>(() => ExtrasRepoImpl(locator()))
    ..registerLazySingleton<MoviesRepo>(() => MoviesRepoImpl(locator()))
    ..registerLazySingleton<TvShowsRepo>(() => TvShowsRepoImpl(locator()));
}
