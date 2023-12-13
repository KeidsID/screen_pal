import 'package:flutter/material.dart';

import 'package:screen_pal/core/services/cache/theme_mode_cache.dart';

final class SetThemeMode {
  const SetThemeMode({required ThemeModeCache themeModeCache})
      : _themeModeCache = themeModeCache;

  final ThemeModeCache _themeModeCache;

  Future<bool> execute(ThemeMode mode) => _themeModeCache.setThemeMode(mode);
}
