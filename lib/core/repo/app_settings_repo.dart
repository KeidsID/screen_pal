import 'package:flutter/material.dart';

/// Everything you need to manage app settings.
abstract interface class AppSettingsRepo {
  Future<bool> setThemeMode(ThemeMode themeMode);
  Future<ThemeMode> getThemeMode();
}
