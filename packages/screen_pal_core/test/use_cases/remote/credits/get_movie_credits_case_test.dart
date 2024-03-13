import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal_core/screen_pal_core.dart';
import '../../../helpers/dummies/credits_dummy.dart';
import '../../../helpers/mocks/internal.mocks.dart';

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
      provideDummy(dummyCredits); // mockito helper

      when(mockMoviesRepo.getMovieCredits(123))
          .thenAnswer((_) async => dummyCredits);

      final genres = await subject.execute(123);

      expect(genres, dummyCredits);
      verify(mockMoviesRepo.getMovieCredits(123)).called(1);
    },
  );
}
