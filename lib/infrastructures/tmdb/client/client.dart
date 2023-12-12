// coverage:ignore-file

import 'package:dio/dio.dart';

import 'package:screen_pal/common/constants.dart';
import 'package:screen_pal/common/envs/env.dart';
import 'package:screen_pal/infrastructures/tmdb/utils/tmdb_images_config.dart';

/// TMDB RestAPI Dio client with configured environment.
///
/// Endpoint reference: https://developer.themoviedb.org/reference
///
/// To use images path from api response, please refer to [tmdbImageBaseUrl].
final tmdbClient = Dio(BaseOptions(
  baseUrl: 'https://api.themoviedb.org/$kTmdbApiVersion',
  headers: {"Authorization": "Bearer ${Env.tmdbAccToken}"},
));
