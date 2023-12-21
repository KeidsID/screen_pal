import 'package:equatable/equatable.dart';

import 'genre.dart';
import 'spoken_language.dart';

final class Extras extends Equatable {
  final List<SpokenLanguage> languages;
  final List<Genre> genres;

  const Extras({
    required this.languages,
    required this.genres,
  });

  /// Returns true if [languages] or [genres] are empty.
  bool get hasEmpty => languages.isEmpty || genres.isEmpty;

  @override
  List<Object> get props => [languages, genres];
}
