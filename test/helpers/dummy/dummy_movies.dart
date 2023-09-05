import 'package:screen_pal/core/entities/movie.dart';

final dummyMovie = Movie(
  adult: false,
  backdropPath: '/dummy.jpg',
  genreIds: const [1],
  id: 1,
  language: 'en',
  originalTitle: 'dummy',
  overview: 'Its dummy movie',
  popularity: 6969.0,
  posterPath: '/dummy-poster.jpg',
  releaseDate: DateTime.now(),
  title: 'dummy',
  voteAverage: 6.9,
  voteCount: 6900,
);

final dummyAdultMovie = Movie(
  adult: true,
  backdropPath: '/mumi.jpg',
  genreIds: const [2],
  id: 2,
  language: 'en',
  originalTitle: 'MUMI',
  overview: 'Its Mummy movie',
  popularity: 1000.0,
  posterPath: '/mumi-poster.jpg',
  releaseDate: DateTime.now(),
  title: 'Mummy',
  voteAverage: 9.1,
  voteCount: 2500,
);

final dummyMovies = [
  dummyMovie,
  dummyAdultMovie,
];
