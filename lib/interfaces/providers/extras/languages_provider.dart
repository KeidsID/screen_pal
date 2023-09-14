import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:screen_pal/core/entities/spoken_language.dart';
import 'package:screen_pal/core/use_cases/extras/get_languages.dart';
import 'package:screen_pal/configs/service_locator/locator.dart' as service;

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
