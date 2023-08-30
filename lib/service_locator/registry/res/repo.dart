part of '../registry.dart';

void registerRepo() {
  locator.registerLazySingleton<MoviesRepo>(() => MoviesRepoImpl(tmdbDio));
}
