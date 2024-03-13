import 'package:screen_pal_core/screen_pal_core.dart';

import 'extras_dummy.dart';

const dummyMovie = Movie(
  id: 1,
  title: 'title',
  overview: 'overview',
  language: 'en',
  genreIds: [],
  originalTitle: 'originalTitle',
  popularity: 1.0,
  voteAverage: 5.0,
  voteCount: 50,
  isAdult: false,
);

const dummyMovieCollectionDetail = MovieCollectionDetail(
  id: 123,
  name: 'name',
  overview: 'overview',
  parts: [dummyMovie],
);

const dummyMovieDetail = MovieDetail(
  id: 123,
  title: 'title',
  originalTitle: 'originalTitle',
  overview: 'overview',
  language: 'en',
  languages: dummyLanguages,
  genres: dummyGenres,
  adult: false,
  status: 'status',
  tagline: 'tagline',
  popularity: 25.02,
  voteAverage: 13.12,
  voteCount: 1970,
  budget: 1000000,
  revenue: 1000000,
  video: false,
);
