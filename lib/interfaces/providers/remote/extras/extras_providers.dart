// coverage:ignore-file

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:screen_pal/core/entities/extras/extras.dart';
import 'package:screen_pal/interfaces/providers/remote/extras/genres_providers.dart';
import 'package:screen_pal/interfaces/providers/remote/extras/languages_provider.dart';

part 'extras_providers.g.dart';

@Riverpod(keepAlive: true, dependencies: [languages, movieGenres])
Extras movieExtras(MovieExtrasRef ref) {
  final langs = ref.watch(languagesProvider);
  final genres = ref.watch(movieGenresProvider);

  return Extras(
    languages: langs.valueOrNull ?? [],
    genres: genres.valueOrNull ?? [],
  );
}

@Riverpod(keepAlive: true, dependencies: [languages, tvShowGenres])
Extras tvShowExtras(TvShowExtrasRef ref) {
  final langs = ref.watch(languagesProvider);
  final genres = ref.watch(tvShowGenresProvider);

  return Extras(
    languages: langs.valueOrNull ?? [],
    genres: genres.valueOrNull ?? [],
  );
}

/// Watch [movieExtras] and [tvShowExtras] dependencies state.
///
/// Note that this provider return nothing, that means all dependencies are ready.
@Riverpod(
  keepAlive: true,
  dependencies: [movieGenres, tvShowGenres, languages],
)
AsyncValue<void> extrasDependenciesState(ExtrasDependenciesStateRef ref) {
  final movieGenresAsync = ref.watch(movieGenresProvider);
  final tvShowGenresAsync = ref.watch(tvShowGenresProvider);
  final languagesAsync = ref.watch(languagesProvider);

  final isLoading = movieGenresAsync.isLoading ||
      tvShowGenresAsync.isLoading ||
      languagesAsync.isLoading;

  final AsyncError? error = movieGenresAsync.asError ??
      tvShowGenresAsync.asError ??
      languagesAsync.asError;

  if (isLoading) return const AsyncLoading<void>();

  if (error != null) return AsyncError<void>(error, error.stackTrace);

  return const AsyncData(null);
}
