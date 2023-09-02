part of '../registry.dart';

void registerRepo() {
  locator.registerLazySingleton<MoviesRepo>(() => MoviesRepoImpl(tmdbDio));
  locator.registerLazySingleton<GenresRepo>(() => GenresRepoImpl(tmdbDio));
}
