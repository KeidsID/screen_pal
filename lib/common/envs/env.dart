// coverage:ignore-file

import 'package:envied/envied.dart';

part 'env.g.dart';

/// Contain environment variables from `.env` file.
@Envied(obfuscate: true, useConstantCase: true)
abstract class Env {
  /// Whether to use path url strategy or flutter default.
  ///
  /// Flutter default web url will have hash ("domain.com/#/path").
  ///
  /// https://github.com/flutter/flutter/issues/89763
  @EnviedField(obfuscate: false, defaultValue: false)
  static const bool isUsePathUrlStrategy = _Env.isUsePathUrlStrategy;

  /// TMDB Access Token.
  ///
  /// https://developer.themoviedb.org/docs/faq#how-do-i-apply-for-an-api-key
  @EnviedField()
  static final String tmdbAccToken = _Env.tmdbAccToken;
}
