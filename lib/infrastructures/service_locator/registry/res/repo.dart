// coverage:ignore-file

part of '../registry.dart';

void registerRepo() {
  locator
    ..registerLazySingleton<AppSettingsRepo>(
        () => AppSettingsRepoImpl(themeModeCache: locator()))
    ..registerLazySingleton<ExtrasRepo>(() => ExtrasRepoImpl(tmdbDio))
    ..registerLazySingleton<MoviesRepo>(() => MoviesRepoImpl(tmdbDio))
    ..registerLazySingleton<TvShowsRepo>(() => TvShowsRepoImpl(tmdbDio));
}
