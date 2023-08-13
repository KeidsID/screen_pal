import 'package:shared_preferences/shared_preferences.dart';

import '../../../infrastructures/cache/theme_mode_cache.dart';
import '../../locator.dart';

Future<void> registerServices() async {
  final preferences = await SharedPreferences.getInstance();

  locator.registerLazySingleton(() => ThemeModeCache(preferences));
}
