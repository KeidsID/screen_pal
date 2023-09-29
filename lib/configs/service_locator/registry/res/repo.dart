// coverage:ignore-file

part of '../registry.dart';

void registerRepo() {
  locator.registerLazySingleton<AppSettingsRepo>(() {
    return AppSettingsRepoImpl(
      themeModeCache: locator(),
    );
  });
  locator.registerLazySingleton<ExtrasRepo>(() => ExtrasRepoImpl(tmdbDio));
  locator.registerLazySingleton<MoviesRepo>(() => MoviesRepoImpl(tmdbDio));
  locator.registerLazySingleton<TvShowsRepo>(() => TvShowsRepoImpl(tmdbDio));
}
