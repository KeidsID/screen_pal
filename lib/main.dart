import 'package:flutter/material.dart';

import 'interfaces/themes/espresso_and_crema_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: EspressoAndCremaTheme.light,
      darkTheme: EspressoAndCremaTheme.dark,
      themeMode: ThemeMode.system,
      home: const Scaffold(
        body: Center(child: Text('Hello World!')),
      ),
    );
  }
}
