// coverage:ignore-file

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:screen_pal/core/entities/extras/extras.dart';
import 'package:screen_pal/interfaces/providers/extras/genres_providers.dart';
import 'package:screen_pal/interfaces/providers/extras/languages_provider.dart';

part 'extras_providers.g.dart';

@Riverpod(keepAlive: true, dependencies: [Languages, MovieGenres])
Extras movieExtras(MovieExtrasRef ref) {
  final languages = ref.watch(languagesProvider);
  final genres = ref.watch(movieGenresProvider);

  return Extras(languages: languages, genres: genres);
}

@Riverpod(keepAlive: true, dependencies: [Languages, TvShowGenres])
Extras tvShowExtras(TvShowExtrasRef ref) {
  final languages = ref.watch(languagesProvider);
  final genres = ref.watch(tvShowGenresProvider);

  return Extras(languages: languages, genres: genres);
}
