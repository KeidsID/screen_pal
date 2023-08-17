import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:screen_pal/interfaces/providers/app_theme_mode_provider.dart';

class ThemeModeDropdownButton extends ConsumerWidget {
  const ThemeModeDropdownButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeModeProvider);
    final themeModeNotifier = ref.read(appThemeModeProvider.notifier);

    return DropdownButton<ThemeMode>(
      items: ThemeMode.values.map((e) {
        final filteredName = e.name == 'system' ? 'system default' : e.name;
        final icons = {
          'system': Icons.color_lens_outlined,
          'light': Icons.light_mode_outlined,
          'dark': Icons.dark_mode_outlined,
        };

        return DropdownMenuItem(
          value: e,
          child: Row(
            children: [
              Icon(icons[e.name]),
              const SizedBox(width: 8),
              Text(filteredName),
            ],
          ),
        );
      }).toList(),
      value: themeMode,
      onChanged: (value) => themeModeNotifier.updateMode(value!),
    );
  }
}
