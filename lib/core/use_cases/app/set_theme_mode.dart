import 'package:flutter/material.dart';

import 'package:screen_pal/core/repo/app_settings_repo.dart';

class SetThemeMode {
  final AppSettingsRepo appSettingsRepo;

  SetThemeMode({required this.appSettingsRepo});

  Future<bool> execute(ThemeMode mode) => appSettingsRepo.setThemeMode(mode);
}
