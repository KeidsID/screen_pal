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

  return movieGenresAsync.when(
    skipLoadingOnRefresh: false,
    loading: () => const AsyncLoading(),
    error: (error, trace) => AsyncError(error, trace),
    data: (_) => tvShowGenresAsync.when(
      skipLoadingOnRefresh: false,
      loading: () => const AsyncLoading(),
      error: (error, trace) => AsyncError(error, trace),
      data: (_) => languagesAsync.when(
        skipLoadingOnRefresh: false,
        loading: () => const AsyncLoading(),
        error: (error, trace) => AsyncError(error, trace),
        data: (_) => const AsyncData(null),
      ),
    ),
  );
}
