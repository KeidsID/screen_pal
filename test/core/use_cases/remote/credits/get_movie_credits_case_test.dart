import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal/core/use_cases/remote/credits/get_movie_credits_case.dart';

import '../../../../helpers/dummy/dummy_credits.dart';
import '../../../../helpers/mocks/internal.mocks.dart';

void main() {
  late GetMovieCreditsCase subject;
  late MockMoviesRepo mockMoviesRepo;

  setUp(() {
    mockMoviesRepo = MockMoviesRepo();
    subject = GetMovieCreditsCase(moviesRepo: mockMoviesRepo);
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