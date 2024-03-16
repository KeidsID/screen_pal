import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_utilities/fl_utilities.dart';

import 'common/asset_paths.dart';
import 'common/constants.dart';
import 'common/envs/env.dart';
import 'infrastructures/container/container.dart' as container;
import 'interfaces/providers/cache/app_theme_mode_provider.dart';
import 'interfaces/providers/remote/extras/extras_providers.dart';
import 'interfaces/router/router.dart';
import 'interfaces/themes/app_themes.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  LicenseRegistry.addLicense(() async* {
    final rubikLicense =
        await rootBundle.loadString(AssetPaths.rubikFontLicense);

    yield LicenseEntryWithLineBreaks(['google_fonts_rubik'], rubikLicense);
  });

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
    final extrasState = ref.watch(extrasDependenciesStateProvider);

    if (!_isSplashRemoved && !extrasState.isLoading) {
      FlutterNativeSplash.remove();
      setState(() => _isSplashRemoved = true);
    }

    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      debugShowCheckedModeBanner: false,
      title: kAppName,
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      themeAnimationCurve: Curves.easeOut,
      themeAnimationDuration: const Duration(milliseconds: 500),
      themeMode: ref.watch(appThemeModeProvider),
      scrollBehavior: context.scrollBehavior.copyWith(
        dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
      ),
    );
  }
}
