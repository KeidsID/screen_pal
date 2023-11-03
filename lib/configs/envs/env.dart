// coverage:ignore-file

import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(obfuscate: true)
abstract class Env {
  @EnviedField(
    varName: 'IS_USE_PATH_URL_STRATEGY',
    obfuscate: false,
    defaultValue: true,
  )
  static const bool isUsePathUrlStrategy = _Env.isUsePathUrlStrategy;

  @EnviedField(varName: 'TMDB_ACC_TOKEN')
  static final String tmdbAccToken = _Env.tmdbAccToken;
}
