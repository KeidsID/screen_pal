import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal/core/use_cases/credits/get_movie_credits.dart';

import '../../../helpers/dummy/dummy_credits.dart';
import '../../../helpers/mocks/repositories.mocks.dart';

void main() {
  late GetMovieCredits subject;
  late MockMoviesRepo mockMoviesRepo;

  setUp(() {
    mockMoviesRepo = MockMoviesRepo();
    subject = GetMovieCredits(moviesRepo: mockMoviesRepo);
  });

  test(
    'GetMovieCredits use case '
    'should orchestrating get credits action correctly',
    () async {
      when(mockMoviesRepo.getMovieCredits(123))
          .thenAnswer((_) async => dummyMovieCredits);

      final genres = await subject.execute(123);

      expect(genres, dummyMovieCredits);
      verify(mockMoviesRepo.getMovieCredits(123)).called(1);
    },
  );
}
