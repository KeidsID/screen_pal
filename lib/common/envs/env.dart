import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'TMDB_ACC_TOKEN')
  static final String tmdbAccKey = _Env.tmdbAccKey;
}
