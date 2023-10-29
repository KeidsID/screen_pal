// coverage:ignore-file

import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:screen_pal/configs/service_locator/locator.dart';
import 'package:screen_pal/core/repo/app_settings_repo.dart';
import 'package:screen_pal/core/repo/extras_repo.dart';
import 'package:screen_pal/core/repo/movies_repo.dart';
import 'package:screen_pal/core/repo/tv_shows_repo.dart';
import 'package:screen_pal/core/use_cases.dart';
import 'package:screen_pal/infrastructures/api/tmdb_dio.dart';
import 'package:screen_pal/infrastructures/cache/theme_mode_cache.dart';
import 'package:screen_pal/infrastructures/repo/app_settings_repo_impl.dart';
import 'package:screen_pal/infrastructures/repo/extras_repo_impl.dart';
import 'package:screen_pal/infrastructures/repo/movies_repo_impl.dart';
import 'package:screen_pal/infrastructures/repo/tv_shows_repo_impl.dart';

part 'res/repo.dart';
part 'res/services.dart';
part 'res/use_cases.dart';
