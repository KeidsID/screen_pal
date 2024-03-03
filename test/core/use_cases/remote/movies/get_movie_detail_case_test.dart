import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal/core/use_cases/remote/movies/get_movie_detail_case.dart';

import '../../../../helpers/dummy/dummy_movies.dart';
import '../../../../helpers/mocks/internal.mocks.dart';

void main() {
  late GetMovieDetailCase subject;
  late MockMoviesRepo mockMoviesRepo;

  setUp(() {
    mockMoviesRepo = MockMoviesRepo();
    subject = GetMovieDetailCase(moviesRepo: mockMoviesRepo);
  });

  test(
    'GetMovieDetail use case '
    'should orchestrating get movie detail action correctly',
    () async {
      provideDummy(dummyMovieDetail); // mockito helper

      when(mockMoviesRepo.getMovieDetail(123))
          .thenAnswer((_) async => dummyMovieDetail);

      final movie = await subject.execute(123);

      expect(movie, dummyMovieDetail);
      verify(mockMoviesRepo.getMovieDetail(123)).called(1);
    },
  );
}