import 'dart:convert';

import 'package:screen_pal/infrastructures/tmdb/models/others/raw_spoken_language.dart';

const dummyLanguagesJson = '''[
  {
    "iso_639_1": "en",
    "english_name": "English",
    "name": "English"
  },
  {
    "iso_639_1": "id",
    "english_name": "Indonesian",
    "name": "Bahasa indonesia"
  }
]''';

/// Refer to [dummyLanguagesJson] for the props values.
final dummyLanguages = (jsonDecode(dummyLanguagesJson) as List)
    .map((e) => RawSpokenLanguage.fromJson(e).toEntity())
    .toList();
