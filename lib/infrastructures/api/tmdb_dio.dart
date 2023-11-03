// coverage:ignore-file

import 'package:dio/dio.dart';

import 'package:screen_pal/configs/constants.dart';
import 'package:screen_pal/configs/envs/env.dart';

/// TMDB RestAPI Dio instance with configured environment.
///
/// Endpoint reference: https://developer.themoviedb.org/reference
final tmdbDio = Dio(BaseOptions(
  baseUrl: 'https://api.themoviedb.org/$kTmdbApiVersion',
  headers: {"Authorization": "Bearer ${Env.tmdbAccToken}"},
));

/// Used to load an image based on the path given by the API.
///
/// Example:
/// ```dart
/// const pathFromApi = '/netflix.jpg';
///
/// Image.network('$tmdbImageBaseUrl$pathFromApi');
/// ```
const tmdbImageBaseUrl = 'https://image.tmdb.org/t/p/original';
