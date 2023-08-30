// coverage:ignore-file

part of '../registry.dart';

Future<void> registerServices() async {
  final preferences = await SharedPreferences.getInstance();

  locator.registerLazySingleton(() => ThemeModeCache(preferences));
}
