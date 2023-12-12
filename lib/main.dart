import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'common/constants.dart';
import 'common/envs/env.dart';
import 'infrastructures/container/container.dart' as service;
import 'interfaces/providers/others/app_theme_mode_provider.dart';
import 'interfaces/router/router.dart';
import 'interfaces/router/url_strategy/url_strategy.dart';
import 'interfaces/themes/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await service.init();

  if (Env.isUsePathUrlStrategy) usePathUrlStrategy();

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: kAppName,
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      themeAnimationCurve: Curves.easeOut,
      themeAnimationDuration: const Duration(milliseconds: 500),
      themeMode: ref.watch(appThemeModeProvider),
      scrollBehavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },
      ),
    );
  }
}
