// coverage:ignore-file

import 'package:dio/dio.dart';

import 'package:screen_pal/common/envs/env.dart';

/// TMDB RestAPI Dio instance with configured environment.
///
/// Endpoint reference: https://developer.themoviedb.org/reference
final tmdbDio = Dio(BaseOptions(
  baseUrl: 'https://api.themoviedb.org/3',
  headers: {"Authorization": "Bearer ${Env.tmdbAccKey}"},
));

/// Use to load an image based on the path given by the API.
///
/// Example:
/// ```dart
/// const pathFromApi = '/netflix.jpg';
///
/// Image.network('$tmdbImageBaseUrl$pathFromApi');
/// ```
const tmdbImageBaseUrl = 'https://image.tmdb.org/t/p/original';
