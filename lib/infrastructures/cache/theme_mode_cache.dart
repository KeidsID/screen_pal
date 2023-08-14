import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeCache {
  final SharedPreferences _pref;

  const ThemeModeCache(SharedPreferences preferences) : _pref = preferences;

  static const _key = 'app.theme_mode';
  static const _modes = ThemeMode.values;

  Future<bool> setThemeMode(ThemeMode themeMode) {
    return _pref.setInt(_key, _modes.indexOf(themeMode));
  }

  Future<ThemeMode> getThemeMode() async {
    await _pref.reload();

    final themeModeIndex = _pref.getInt(_key) ?? 0;

    return _modes[themeModeIndex];
  }
}
