import 'package:flutter/material.dart';

abstract interface class ThemeModeCache {
  @protected
  String get cacheKey => 'app.theme_mode';

  Future<bool> setThemeMode(ThemeMode themeMode);
  Future<ThemeMode> getThemeMode();
}
