// coverage:ignore-file

part of '../registry.dart';

void registerServices() {
  locator.registerSingletonAsync(() => SharedPreferences.getInstance());

  locator.registerLazySingleton(() => ThemeModeCache(locator()));
}
