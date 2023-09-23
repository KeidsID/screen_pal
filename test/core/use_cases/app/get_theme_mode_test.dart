import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal/core/use_cases/app/get_theme_mode.dart';

import '../../../helpers/mocks/repo/repositories.mocks.dart';

void main() {
  late GetThemeMode subject;
  late MockAppSettingsRepo mockAppSettingsRepo;

  setUp(() {
    mockAppSettingsRepo = MockAppSettingsRepo();
    subject = GetThemeMode(appSettingsRepo: mockAppSettingsRepo);
  });

  test(
    'GetThemeMode use case should orchestrating get theme mode action correctly',
    () async {
      when(mockAppSettingsRepo.getThemeMode())
          .thenAnswer((_) async => ThemeMode.system);

      final themeMode = await subject.execute();

      expect(themeMode, ThemeMode.system);
      verify(mockAppSettingsRepo.getThemeMode()).called(1);
    },
  );
}
