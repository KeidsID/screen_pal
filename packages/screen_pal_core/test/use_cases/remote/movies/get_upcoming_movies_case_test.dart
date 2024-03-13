import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal_core/screen_pal_core.dart';
import '../../../helpers/mocks/internal.mocks.dart';

void main() {
  late GetUpcomingMoviesCase testUsecase;
  late MockMoviesRepo mockMoviesRepo;

  setUp(() {
    mockMoviesRepo = MockMoviesRepo();
    testUsecase = GetUpcomingMoviesCase(moviesRepo: mockMoviesRepo);
  });

  test(
    'GetUpcomingMovie use case should orchestrating get now playing movies action correctly',
    () async {
      when(mockMoviesRepo.getUpcomingMovies()).thenAnswer((_) async => []);

      final movies = await testUsecase.execute();

      expect(movies, []);
      verify(mockMoviesRepo.getUpcomingMovies()).called(1);
    },
  );
}
