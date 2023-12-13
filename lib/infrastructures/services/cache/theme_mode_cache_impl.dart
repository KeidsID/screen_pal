// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:screen_pal/core/services/cache/theme_mode_cache.dart';

class ThemeModeCacheImpl implements ThemeModeCache {
  final SharedPreferences _pref;

  const ThemeModeCacheImpl(SharedPreferences sharedPreferences)
      : _pref = sharedPreferences;

  @protected
  @visibleForTesting
  String get cacheKey => 'app.theme_mode';

  List<ThemeMode> get _modes => ThemeMode.values;

  @override
  Future<bool> setThemeMode(ThemeMode themeMode) {
    return _pref.setInt(cacheKey, _modes.indexOf(themeMode));
  }

  @override
  Future<ThemeMode> getThemeMode() async {
    await _pref.reload();

    final themeModeIndex = _pref.getInt(cacheKey) ?? 0;

    return _modes[themeModeIndex];
  }
}
