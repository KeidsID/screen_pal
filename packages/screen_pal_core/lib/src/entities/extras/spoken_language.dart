import 'package:equatable/equatable.dart';

final class SpokenLanguage extends Equatable {
  /// [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) code as language id.
  final String iso6391;

  /// Name of the language in native language.
  ///
  /// For example: `Bahasa Indonesia`
  final String name;

  /// Name of the language in English.
  final String englishName;

  const SpokenLanguage({
    required this.iso6391,
    required this.name,
    required this.englishName,
  });

  @override
  List<Object> get props => [iso6391];
}
