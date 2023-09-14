import 'package:flutter/material.dart';

import 'package:screen_pal/core/repo/app_settings_repo.dart';
import 'package:screen_pal/infrastructures/cache/theme_mode_cache.dart';

class AppSettingsRepoImpl implements AppSettingsRepo {
  const AppSettingsRepoImpl({required ThemeModeCache themeModeCache})
      : _themeModeCache = themeModeCache;

  final ThemeModeCache _themeModeCache;

  @override
  Future<ThemeMode> getThemeMode() => _themeModeCache.getThemeMode();

  @override
  Future<bool> setThemeMode(ThemeMode themeMode) =>
      _themeModeCache.setThemeMode(themeMode);
}
