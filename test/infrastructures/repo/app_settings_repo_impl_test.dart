import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal/infrastructures/repo/app_settings_repo_impl.dart';

import '../../helpers/mocks/services.mocks.dart';

void main() {
  late AppSettingsRepoImpl subject;
  late MockThemeModeCache mockThemeModeCache;

  setUpAll(() {
    mockThemeModeCache = MockThemeModeCache();
    subject = AppSettingsRepoImpl(themeModeCache: mockThemeModeCache);
  });

  group('AppSettingRepoImpl', () {
    test('getThemeMode() should return ThemeMode', () async {
      when(mockThemeModeCache.getThemeMode())
          .thenAnswer((_) async => ThemeMode.system);

      final themeMode = await subject.getThemeMode();

      expect(themeMode, ThemeMode.system);
      verify(mockThemeModeCache.getThemeMode()).called(1);
    });

    test(
      'setThemeMode() should return bool for progress status '
      '(is setting theme mode success or fail)',
      () async {
        when(mockThemeModeCache.setThemeMode(ThemeMode.system))
            .thenAnswer((_) async => true);

        final isSuccess = await subject.setThemeMode(ThemeMode.system);

        when(mockThemeModeCache.setThemeMode(ThemeMode.system))
            .thenAnswer((_) async => false);

        final isFail = await subject.setThemeMode(ThemeMode.system);

        expect(isSuccess, true);
        expect(isFail, false);
        verify(mockThemeModeCache.setThemeMode(ThemeMode.system)).called(2);
      },
    );
  });
}
