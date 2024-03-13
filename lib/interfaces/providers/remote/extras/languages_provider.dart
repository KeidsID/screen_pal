// coverage:ignore-file

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:screen_pal/infrastructures/container/container.dart' as service;
import 'package:screen_pal_core/screen_pal_core.dart';

part 'languages_provider.g.dart';

@Riverpod(keepAlive: true, dependencies: [])
Future<List<SpokenLanguage>> languages(LanguagesRef ref) {
  return service.locator<GetLanguagesCase>().execute();
}
