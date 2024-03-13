// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:screen_pal/infrastructures/container/container.dart'
    as container;
import 'package:screen_pal_core/screen_pal_core.dart';

part 'app_theme_mode_provider.g.dart';

// satisfies dependency lint warning for override provider on test
@Riverpod(keepAlive: true, dependencies: [])
class AppThemeMode extends _$AppThemeMode {
  @override
  ThemeMode build() {
    _init();

    return ThemeMode.system;
  }

  Future<void> _init() async {
    final themeMode = await container.locator<GetThemeModeCase>().execute();

    state = themeMode;
  }

  Future<void> updateMode(ThemeMode mode) async {
    await container.locator<SetThemeModeCase>().execute(mode);
    state = mode;
  }
}
