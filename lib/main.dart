import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'common/constants.dart';
import 'common/envs/env.dart';
import 'interfaces/providers/app_theme_mode_provider.dart';
import 'interfaces/router/router.dart';
import 'interfaces/router/url_strategy/url_strategy.dart'
    show usePathUrlStrategy;
import 'interfaces/themes/espresso_and_crema_theme.dart';
import 'service_locator/locator.dart' as service;

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
      theme: EspressoAndCremaTheme.light,
      darkTheme: EspressoAndCremaTheme.dark,
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
