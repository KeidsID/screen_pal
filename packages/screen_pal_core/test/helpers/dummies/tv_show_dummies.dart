import 'package:screen_pal_core/screen_pal_core.dart';

import 'extras_dummy.dart';

const dummyTvShow = TvShow(
  id: 123,
  title: 'title',
  overview: 'overview',
  language: 'en',
  genreIds: [28],
  originalTitle: 'originalTitle',
  popularity: 25.02,
  voteAverage: 13.12,
  voteCount: 1970,
);

const dummyTvShowDetail = TvShowDetail(
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
  popularity: 13.12,
  voteAverage: 19.70,
  voteCount: 2502,
  type: 'type',
  seasons: [],
  episodeCount: 0,
  seasonCount: 0,
);
