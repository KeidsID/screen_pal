import 'package:screen_pal_core/screen_pal_core.dart';

const dummyGenres = [
  Genre(id: 28, name: 'Action'),
  Genre(id: 12, name: 'Adventure'),
  Genre(id: 16, name: 'Animation'),
];

const dummyLanguages = [
  SpokenLanguage(englishName: 'English', iso6391: 'en', name: 'English'),
  SpokenLanguage(
    englishName: 'Indonesian',
    iso6391: 'id',
    name: 'Bahasa Indonesia',
  ),
];

const dummyExtras = Extras(
  genres: dummyGenres,
  languages: dummyLanguages,
);
