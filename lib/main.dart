import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'common/constants.dart';
import 'interfaces/pages/home_page.dart';
import 'interfaces/providers/app_theme_mode_provider.dart';
import 'interfaces/themes/espresso_and_crema_theme.dart';
import 'service_locator/locator.dart' as service;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await service.init();

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: EspressoAndCremaTheme.light,
      darkTheme: EspressoAndCremaTheme.dark,
      themeMode: ref.watch(appThemeModeProvider),
      home: const HomePage(),
    );
  }
}
