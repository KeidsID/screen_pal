// coverage:ignore-file

part of '../registry.dart';

void registerServices() {
  locator
    ..registerLazySingleton(() => ThemeModeCache(locator()))

    // external services
    ..registerSingletonAsync(() => PackageInfo.fromPlatform())
    ..registerSingletonAsync(() => SharedPreferences.getInstance());
}
