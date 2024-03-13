import 'package:flutter/material.dart';

import 'package:screen_pal_core/src/services.dart';

final class SetThemeModeCase {
  const SetThemeModeCase({required ThemeModeCache themeModeCache})
      : _themeModeCache = themeModeCache;

  final ThemeModeCache _themeModeCache;

  Future<bool> execute(ThemeMode mode) => _themeModeCache.setThemeMode(mode);
}
