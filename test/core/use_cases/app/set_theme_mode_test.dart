import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal/core/use_cases/app/set_theme_mode.dart';

import '../../../helpers/mocks/repositories.mocks.dart';

void main() {
  late SetThemeMode subject;
  late MockAppSettingsRepo mockAppSettingsRepo;

  setUp(() {
    mockAppSettingsRepo = MockAppSettingsRepo();
    subject = SetThemeMode(appSettingsRepo: mockAppSettingsRepo);
  });

  test(
    'SetThemeMode use case should orchestrating set theme mode action correctly',
    () async {
      when(mockAppSettingsRepo.getThemeMode())
          .thenAnswer((_) async => ThemeMode.system);
      when(mockAppSettingsRepo.setThemeMode(ThemeMode.dark))
          .thenAnswer((_) async => true);

      final previousThemeMode = await mockAppSettingsRepo.getThemeMode();

      final isSuccess = await subject.execute(ThemeMode.dark);

      when(mockAppSettingsRepo.getThemeMode())
          .thenAnswer((_) async => ThemeMode.dark);

      final afterThemeMode = await mockAppSettingsRepo.getThemeMode();

      expect(isSuccess, true);
      expect(previousThemeMode, ThemeMode.system);
      expect(afterThemeMode, ThemeMode.dark);
      verify(mockAppSettingsRepo.setThemeMode(ThemeMode.dark)).called(1);
    },
  );
}
