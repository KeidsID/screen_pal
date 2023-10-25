import 'package:flutter/material.dart';

import 'package:screen_pal/core/repo/app_settings_repo.dart';

final class GetThemeMode {
  const GetThemeMode({required AppSettingsRepo appSettingsRepo})
      : _appSettingsRepo = appSettingsRepo;

  final AppSettingsRepo _appSettingsRepo;

  Future<ThemeMode> execute() => _appSettingsRepo.getThemeMode();
}
