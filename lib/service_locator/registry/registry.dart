// coverage:ignore-file

import 'package:shared_preferences/shared_preferences.dart';

import 'package:screen_pal/core/repo/extras_repo.dart';
import 'package:screen_pal/core/repo/movies_repo.dart';
import 'package:screen_pal/core/use_cases/extras/get_languages.dart';
import 'package:screen_pal/core/use_cases/extras/get_movie_genres.dart';
import 'package:screen_pal/core/use_cases/extras/get_tv_show_genres.dart';
import 'package:screen_pal/core/use_cases/movies/get_movie_detail.dart';
import 'package:screen_pal/core/use_cases/movies/get_movie_recommendations.dart';
import 'package:screen_pal/core/use_cases/movies/get_now_playing_movies.dart';
import 'package:screen_pal/core/use_cases/movies/get_popular_movies.dart';
import 'package:screen_pal/core/use_cases/movies/get_top_rated_movies.dart';
import 'package:screen_pal/core/use_cases/movies/get_upcoming_movies.dart';
import 'package:screen_pal/infrastructures/api/tmdb_dio.dart';
import 'package:screen_pal/infrastructures/cache/theme_mode_cache.dart';
import 'package:screen_pal/infrastructures/repo/extras_repo_impl.dart';
import 'package:screen_pal/infrastructures/repo/movies_repo_impl.dart';
import 'package:screen_pal/service_locator/locator.dart';

part 'res/repo.dart';
part 'res/services.dart';
part 'res/use_cases.dart';
