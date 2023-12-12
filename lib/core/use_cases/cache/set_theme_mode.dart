import 'package:flutter/material.dart';

import 'package:screen_pal/core/services/cache/theme_mode_cache.dart';

final class SetThemeMode {
  const SetThemeMode({required ThemeModeCache appSettingsRepo})
      : _appSettingsRepo = appSettingsRepo;

  final ThemeModeCache _appSettingsRepo;

  Future<bool> execute(ThemeMode mode) => _appSettingsRepo.setThemeMode(mode);
}
