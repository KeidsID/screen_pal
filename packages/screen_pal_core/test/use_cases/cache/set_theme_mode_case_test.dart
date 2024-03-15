import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal_core/screen_pal_core.dart';
import '../../helpers/mocks/internal.mocks.dart';

void main() {
  late SetThemeModeCase subject;
  late MockThemeModeCache mockThemeModeCache;

  setUp(() {
    mockThemeModeCache = MockThemeModeCache();
    subject = SetThemeModeCase(themeModeCache: mockThemeModeCache);
  });

  test(
    'SetThemeModeCase - should orchestrating set theme mode action correctly',
    () async {
      when(mockThemeModeCache.getThemeMode())
          .thenAnswer((_) async => ThemeMode.system);
      when(mockThemeModeCache.setThemeMode(ThemeMode.dark))
          .thenAnswer((_) async => true);

      final previousThemeMode = await mockThemeModeCache.getThemeMode();

      final isSuccess = await subject.execute(ThemeMode.dark);

      when(mockThemeModeCache.getThemeMode())
          .thenAnswer((_) async => ThemeMode.dark);

      final afterThemeMode = await mockThemeModeCache.getThemeMode();

      expect(isSuccess, true);
      expect(previousThemeMode, ThemeMode.system);
      expect(afterThemeMode, ThemeMode.dark);
      verify(mockThemeModeCache.setThemeMode(ThemeMode.dark)).called(1);
    },
  );
}
