import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../infrastructures/cache/theme_mode_cache.dart';
import '../../service_locator/locator.dart';

part 'app_theme_mode_provider.g.dart';

@riverpod
class AppThemeMode extends _$AppThemeMode {
  static final _cache = locator<ThemeModeCache>();

  @override
  ThemeMode build() {
    _init();

    return ThemeMode.system;
  }

  Future<void> _init() async {
    final themeMode = await _cache.getThemeMode();

    state = themeMode;
  }

  Future<void> updateMode(ThemeMode mode) async {
    await _cache.setThemeMode(mode);
    state = mode;
  }
}
