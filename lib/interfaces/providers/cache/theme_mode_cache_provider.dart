// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:screen_pal/infrastructures/container/container.dart'
    as container;
import 'package:screen_pal/core/use_cases/cache/get_theme_mode.dart';
import 'package:screen_pal/core/use_cases/cache/set_theme_mode.dart';

part 'theme_mode_cache_provider.g.dart';

// satisfies dependency lint warning for override provider on test
@Riverpod(keepAlive: true, dependencies: [])
class ThemeModeCache extends _$ThemeModeCache {
  @override
  ThemeMode build() {
    _init();

    return ThemeMode.system;
  }

  Future<void> _init() async {
    final themeMode = await container.locator<GetThemeMode>().execute();

    state = themeMode;
  }

  Future<void> updateMode(ThemeMode mode) async {
    await container.locator<SetThemeMode>().execute(mode);
    state = mode;
  }
}
