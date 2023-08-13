import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/constants.dart';
import '../providers/app_theme_mode_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        actions: [
          Consumer(builder: (context, ref, child) {
            final themeMode = ref.watch(appThemeModeProvider);
            final themeModeNotifier = ref.read(appThemeModeProvider.notifier);

            return DropdownButton<ThemeMode>(
              items: ThemeMode.values
                  .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                  .toList(),
              value: themeMode,
              onChanged: (value) => themeModeNotifier.updateMode(value!),
            );
          }),
        ],
      ),
      body: const Center(child: Text('Hello World!')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
