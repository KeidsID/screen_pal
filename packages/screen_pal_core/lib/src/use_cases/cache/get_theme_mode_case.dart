import 'package:flutter/material.dart';

import 'package:screen_pal_core/src/services.dart';

final class GetThemeModeCase {
  const GetThemeModeCase({required ThemeModeCache themeModeCache})
      : _themeModeCache = themeModeCache;

  final ThemeModeCache _themeModeCache;

  Future<ThemeMode> execute() => _themeModeCache.getThemeMode();
}
