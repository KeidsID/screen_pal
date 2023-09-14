// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:screen_pal/configs/service_locator/locator.dart' as service;
import 'package:screen_pal/core/use_cases/app/get_theme_mode.dart';
import 'package:screen_pal/core/use_cases/app/set_theme_mode.dart';

part 'app_theme_mode_provider.g.dart';

@Riverpod(dependencies: [])
class AppThemeMode extends _$AppThemeMode {
  @override
  ThemeMode build() {
    _init();

    return ThemeMode.system;
  }

  Future<void> _init() async {
    final themeMode = await service.locator<GetThemeMode>().execute();

    state = themeMode;
  }

  Future<void> updateMode(ThemeMode mode) async {
    await service.locator<SetThemeMode>().execute(mode);
    state = mode;
  }
}
