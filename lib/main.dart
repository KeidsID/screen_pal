import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'common/constants.dart';
import 'common/envs/env.dart';
import 'infrastructures/container/container.dart' as container;
import 'interfaces/providers/cache/app_theme_mode_provider.dart';
import 'interfaces/providers/remote/extras/genres_providers.dart';
import 'interfaces/providers/remote/extras/languages_provider.dart';
import 'interfaces/router/router.dart';
import 'interfaces/router/url_strategy/url_strategy.dart';
import 'interfaces/themes/app_themes.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await container.init();

  if (Env.isUsePathUrlStrategy) usePathUrlStrategy();

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  bool _isSplashRemoved = false;

  @override
  Widget build(BuildContext context) {
    final movieGenres = ref.watch(movieGenresProvider);
    final tvShowGenres = ref.watch(tvShowGenresProvider);
    final languages = ref.watch(languagesProvider);

    if (!_isSplashRemoved &&
        movieGenres.isNotEmpty &&
        tvShowGenres.isNotEmpty &&
        languages.isNotEmpty) {
      FlutterNativeSplash.remove();
      setState(() => _isSplashRemoved = true);
    }

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
