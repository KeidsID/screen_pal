import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal/infrastructures/services/cache/theme_mode_cache_impl.dart';

import '../../../helpers/mocks/external.mocks.dart';

void main() {
  late ThemeModeCacheImpl subject;
  late MockSharedPreferences mockSharedPreferences;

  setUpAll(() {
    mockSharedPreferences = MockSharedPreferences();
    subject = ThemeModeCacheImpl(mockSharedPreferences);
  });

  group('AppSettingRepoImpl', () {
    test('getThemeMode() should return ThemeMode', () async {
      when(mockSharedPreferences.getInt(subject.cacheKey)).thenReturn(null);

      final themeMode = await subject.getThemeMode();

      expect(themeMode, ThemeMode.system); // default value if no cache
      verify(mockSharedPreferences.getInt(subject.cacheKey)).called(1);
    });

    test(
      'setThemeMode() should return bool for progress status '
      '(is setting theme mode success or fail)',
      () async {
        when(mockSharedPreferences.setInt(
          subject.cacheKey,
          ThemeMode.system.index,
        )).thenAnswer((_) async => true);

        final isSuccess = await subject.setThemeMode(ThemeMode.system);

        when(mockSharedPreferences.setInt(
          subject.cacheKey,
          ThemeMode.system.index,
        )).thenAnswer((_) async => false);

        final isFail = await subject.setThemeMode(ThemeMode.system);

        expect(isSuccess, true);
        expect(isFail, false);
        verify(mockSharedPreferences.setInt(
          subject.cacheKey,
          ThemeMode.system.index,
        )).called(2);
      },
    );
  });
}
