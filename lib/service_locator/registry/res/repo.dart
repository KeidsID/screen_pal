part of '../registry.dart';

void registerRepo() {
  locator.registerLazySingleton<MoviesRepo>(() => MoviesRepoImpl(tmdbDio));
  locator.registerLazySingleton<ExtrasRepo>(() => ExtrasRepoImpl(tmdbDio));
}
