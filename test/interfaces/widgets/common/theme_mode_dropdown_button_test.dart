import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:screen_pal/interfaces/providers/cache/app_theme_mode_provider.dart';
import 'package:screen_pal/interfaces/widgets/others/theme_mode_dropdown_button.dart';

void main() {
  final testWidgetApp = ProviderScope(
    overrides: [
      appThemeModeProvider.overrideWith(() => _FakeAppThemeModeNotifier()),
    ],
    child: Consumer(
      builder: (_, ref, __) {
        final appThemeMode = ref.watch(appThemeModeProvider);

        return MaterialApp(
          themeMode: appThemeMode,
          home: const Scaffold(body: ThemeModeDropdownButton()),
        );
      },
    ),
  );

  group('ThemeModeDropdownButton widget', () {
    testWidgets('should render correctly', (tester) async {
      await tester.pumpWidget(testWidgetApp);

      // expect [DropdownButton] to have initial value from provider.
      expect(
        tester.widget(_WidgetFinders.dropdownButton),
        isA<DropdownButton<ThemeMode>>().having(
          (e) => e.value,
          'DropdownButton.value',
          ThemeMode.system,
        ),
      );

      // open the [DropdownButton] menus
      await tester.tap(_WidgetFinders.dropdownButton);
      await tester.pumpAndSettle();

      // expect every items rendered correctly
      expect(
        tester.widget(_WidgetFinders.systemDefaultItem),
        isA<DropdownMenuItem<ThemeMode>>().having(
          (e) => e.value,
          'DropdownMenuItem.value',
          ThemeMode.system,
        ),
      );
      expect(
        tester.widget(_WidgetFinders.lightItem),
        isA<DropdownMenuItem<ThemeMode>>().having(
          (e) => e.value,
          'DropdownMenuItem.value',
          ThemeMode.light,
        ),
      );
      expect(
        tester.widget(_WidgetFinders.darkItem),
        isA<DropdownMenuItem<ThemeMode>>().having(
          (e) => e.value,
          'DropdownMenuItem.value',
          ThemeMode.dark,
        ),
      );
    });

    testWidgets('should update the app ThemeMode', (tester) async {
      await tester.pumpWidget(testWidgetApp);

      // open the [DropdownButton] menus
      await tester.tap(_WidgetFinders.dropdownButton);
      await tester.pumpAndSettle();

      // change theme mode to light
      await tester.tap(_WidgetFinders.lightItem, warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(
        tester.widget(_WidgetFinders.dropdownButton),
        isA<DropdownButton<ThemeMode>>().having(
          (e) => e.value,
          'DropdownButton.value',
          ThemeMode.light,
        ),
      );
      expect(
        tester.widget(_WidgetFinders.materialApp),
        isA<MaterialApp>().having(
          (e) => e.themeMode,
          'MaterialApp.themeMode',
          ThemeMode.light,
        ),
      );

      // open the [DropdownButton] menus
      await tester.tap(_WidgetFinders.dropdownButton);
      await tester.pumpAndSettle();

      // change theme mode to dark
      await tester.tap(_WidgetFinders.darkItem, warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(
        tester.widget(_WidgetFinders.dropdownButton),
        isA<DropdownButton<ThemeMode>>().having(
          (e) => e.value,
          'DropdownButton.value',
          ThemeMode.dark,
        ),
      );
      expect(
        tester.widget(_WidgetFinders.materialApp),
        isA<MaterialApp>().having(
          (e) => e.themeMode,
          'MaterialApp.themeMode',
          ThemeMode.dark,
        ),
      );

      // change theme mode to dark
      await tester.tap(_WidgetFinders.darkItem);
      await tester.pumpAndSettle();

      expect(
        tester.widget(_WidgetFinders.dropdownButton),
        isA<DropdownButton<ThemeMode>>().having(
          (e) => e.value,
          'DropdownButton.value',
          ThemeMode.dark,
        ),
      );
      expect(
        tester.widget(_WidgetFinders.materialApp),
        isA<MaterialApp>().having(
          (e) => e.themeMode,
          'MaterialApp.themeMode',
          ThemeMode.dark,
        ),
      );
    });
  });
}

class _FakeAppThemeModeNotifier extends AppThemeMode {
  @override
  ThemeMode build() {
    return ThemeMode.system;
  }

  @override
  Future<void> updateMode(ThemeMode mode) async {
    state = mode;
  }
}

abstract class _WidgetFinders {
  static final materialApp = find.byType(MaterialApp);
  static final dropdownButton = find.byType(DropdownButton<ThemeMode>);

  /// [DropdownMenuItem] with [ThemeMode.system] value.
  static final systemDefaultItem = find.byKey(const Key('item-system')).last;

  /// [DropdownMenuItem] with [ThemeMode.light] value.
  static final lightItem = find.byKey(const Key('item-light')).last;

  /// [DropdownMenuItem] with [ThemeMode.dark] value.
  static final darkItem = find.byKey(const Key('item-dark')).last;
}
