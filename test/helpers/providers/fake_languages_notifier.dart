import 'package:screen_pal/core/entities/spoken_language.dart';
import 'package:screen_pal/interfaces/providers/extras/languages_provider.dart';

class FakeLanguagesNotifier extends Languages {
  @override
  List<SpokenLanguage> build() {
    return [
      const SpokenLanguage(
        englishName: 'English',
        iso6391: 'en',
        name: 'English',
      ),
      const SpokenLanguage(
        englishName: 'Indonesian',
        iso6391: 'id',
        name: 'Bahasa indonesia',
      ),
    ];
  }
}
