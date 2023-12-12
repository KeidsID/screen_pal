import 'package:flutter/material.dart';

import 'package:screen_pal/core/services/cache/theme_mode_cache.dart';

final class GetThemeMode {
  const GetThemeMode({required ThemeModeCache appSettingsRepo})
      : _appSettingsRepo = appSettingsRepo;

  final ThemeModeCache _appSettingsRepo;

  Future<ThemeMode> execute() => _appSettingsRepo.getThemeMode();
}
