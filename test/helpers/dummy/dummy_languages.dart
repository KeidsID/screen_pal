import 'dart:convert';

import 'package:screen_pal/infrastructures/api/models/movies/raw_spoken_language.dart';

const dummyRawLanguagesResBody = '''
[
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
]
''';

/// Refer to [dummyRawLanguagesResBody] for the props values.
final dummyLanguages = (jsonDecode(dummyRawLanguagesResBody) as List)
    .map((e) => RawSpokenLanguage.fromJson(e).toEntity())
    .toList();
