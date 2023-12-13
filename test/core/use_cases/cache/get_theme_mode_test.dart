import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal/core/use_cases/cache/get_theme_mode.dart';

import '../../../helpers/mocks/internal.mocks.dart';

void main() {
  late GetThemeMode subject;
  late MockThemeModeCache mockThemeModeCache;

  setUp(() {
    mockThemeModeCache = MockThemeModeCache();
    subject = GetThemeMode(themeModeCache: mockThemeModeCache);
  });

  test(
    'GetThemeMode use case should orchestrating get theme mode action correctly',
    () async {
      when(mockThemeModeCache.getThemeMode())
          .thenAnswer((_) async => ThemeMode.system);

      final themeMode = await subject.execute();

      expect(themeMode, ThemeMode.system);
      verify(mockThemeModeCache.getThemeMode()).called(1);
    },
  );
}
