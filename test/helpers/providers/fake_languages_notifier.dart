import 'package:screen_pal/core/entities/extras/spoken_language.dart';
import 'package:screen_pal/interfaces/providers/extras/languages_provider.dart';

import '../dummy/dummy_languages.dart';

class FakeLanguagesNotifier extends Languages {
  @override
  List<SpokenLanguage> build() => dummyLanguages;
}
