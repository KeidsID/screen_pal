import 'package:dio/dio.dart';

import '../../common/envs/env.dart';

/// TMDB RestAPI Dio instance with configured environment.
///
/// Endpoint reference: https://developer.themoviedb.org/reference
final tmdbDio = Dio(BaseOptions(
  baseUrl: 'https://api.themoviedb.org/3',
  headers: {"Authorization": "Bearer ${Env.tmdbAccKey}"},
));
