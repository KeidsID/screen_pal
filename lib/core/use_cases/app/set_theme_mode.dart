import 'package:flutter/material.dart';

import 'package:screen_pal/core/repo/app_settings_repo.dart';

final class SetThemeMode {
  const SetThemeMode({required AppSettingsRepo appSettingsRepo})
      : _appSettingsRepo = appSettingsRepo;

  final AppSettingsRepo _appSettingsRepo;

  Future<bool> execute(ThemeMode mode) => _appSettingsRepo.setThemeMode(mode);
}
