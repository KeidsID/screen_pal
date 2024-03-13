import 'package:flutter/material.dart';

abstract interface class ThemeModeCache {
  Future<bool> setThemeMode(ThemeMode themeMode);
  Future<ThemeMode> getThemeMode();
}
