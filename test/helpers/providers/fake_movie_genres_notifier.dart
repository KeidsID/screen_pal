import 'package:screen_pal/core/entities/extras/genre.dart';
import 'package:screen_pal/interfaces/providers/extras/genres_providers.dart';

import '../dummy/dummy_genres.dart';

class FakeMovieGenresNotifier extends MovieGenres {
  @override
  List<Genre> build() {
    return dummyGenres;
  }
}
