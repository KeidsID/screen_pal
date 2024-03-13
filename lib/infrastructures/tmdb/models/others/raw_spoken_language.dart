// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:screen_pal_core/screen_pal_core.dart';

part 'raw_spoken_language.freezed.dart';
part 'raw_spoken_language.g.dart';

/// TMDB Api object model for spoken language.
@freezed
class RawSpokenLanguage with _$RawSpokenLanguage {
  const RawSpokenLanguage._();

  const factory RawSpokenLanguage({
    @JsonKey(name: 'english_name') required String englishName,

    /// {@template screen_pal.infrastructures.api.models.languageCode}
    /// Its language `ISO 639-1` code.
    /// {@endtemplate}
    @JsonKey(name: 'iso_639_1') required String iso6391,
    required String name,
  }) = _RawSpokenLanguage;

  factory RawSpokenLanguage.fromJson(Map<String, dynamic> json) =>
      _$RawSpokenLanguageFromJson(json);

  SpokenLanguage toEntity() {
    return SpokenLanguage(
      englishName: englishName,
      iso6391: iso6391,
      name: name,
    );
  }
}
