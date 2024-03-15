import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal_core/screen_pal_core.dart';
import '../../../helpers/dummies/movie_dummies.dart';
import '../../../helpers/mocks/internal.mocks.dart';

void main() {
  late GetMovieDetailCase subject;
  late MockMoviesRepo mockMoviesRepo;

  setUp(() {
    mockMoviesRepo = MockMoviesRepo();
    subject = GetMovieDetailCase(moviesRepo: mockMoviesRepo);
  });

  test(
    'GetMovieDetailCase - should orchestrating get movie detail action correctly',
    () async {
      provideDummy(dummyMovieDetail); // mockito helper

      when(mockMoviesRepo.getMovieDetail(123))
          .thenAnswer((_) async => dummyMovieDetail);

      final movieDetail = await subject.execute(123);

      expect(movieDetail, dummyMovieDetail);
      verify(mockMoviesRepo.getMovieDetail(123)).called(1);
    },
  );
}
