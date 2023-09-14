import 'package:flutter/material.dart';

import 'package:screen_pal/core/repo/app_settings_repo.dart';

class GetThemeMode {
  final AppSettingsRepo appSettingsRepo;

  GetThemeMode({required this.appSettingsRepo});

  Future<ThemeMode> execute() => appSettingsRepo.getThemeMode();
}
