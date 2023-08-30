// coverage:ignore-file

import 'package:shared_preferences/shared_preferences.dart';

import 'package:screen_pal/core/repo/movies_repo.dart';
import 'package:screen_pal/core/use_cases/movie/get_now_playing_movies.dart';
import 'package:screen_pal/core/use_cases/movie/get_popular_movies.dart';
import 'package:screen_pal/core/use_cases/movie/get_top_rated_movies.dart';
import 'package:screen_pal/core/use_cases/movie/get_upcoming_movies.dart';
import 'package:screen_pal/infrastructures/api/tmdb_dio.dart';
import 'package:screen_pal/infrastructures/cache/theme_mode_cache.dart';
import 'package:screen_pal/infrastructures/repo/movies_repo_impl.dart';
import 'package:screen_pal/service_locator/locator.dart';

part 'res/repo.dart';
part 'res/services.dart';
part 'res/use_cases.dart';
