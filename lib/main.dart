import 'package:flutter/material.dart';
import 'package:screen_pal/common/constants.dart';

import 'interfaces/themes/espresso_and_crema_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: EspressoAndCremaTheme.light,
      darkTheme: EspressoAndCremaTheme.dark,
      themeMode: ThemeMode.system,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appName),
        ),
        body: const Center(child: Text('Hello World!')),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
