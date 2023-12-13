// coverage:ignore-file

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:screen_pal/infrastructures/container/container.dart' as service;
import 'package:screen_pal/core/entities/extras/spoken_language.dart';
import 'package:screen_pal/core/use_cases/remote/extras/get_languages.dart';

part 'languages_provider.g.dart';

@Riverpod(keepAlive: true, dependencies: [])
class Languages extends _$Languages {
  @override
  List<SpokenLanguage> build() {
    _init();

    return [];
  }

  Future<void> _init() async {
    try {
      state = await service.locator<GetLanguages>().execute();
    } catch (e) {
      state = [];
    }
  }
}
