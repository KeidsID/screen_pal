import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal_core/screen_pal_core.dart';
import '../../../helpers/mocks/internal.mocks.dart';

void main() {
  late GetTopRatedMoviesCase testUsecase;
  late MockMoviesRepo mockMoviesRepo;

  setUp(() {
    mockMoviesRepo = MockMoviesRepo();
    testUsecase = GetTopRatedMoviesCase(moviesRepo: mockMoviesRepo);
  });

  test(
    'GetTopRatedMovieCase - should orchestrating get now playing movies action correctly',
    () async {
      when(mockMoviesRepo.getTopRatedMovies()).thenAnswer((_) async => []);

      final movies = await testUsecase.execute();

      expect(movies, []);
      verify(mockMoviesRepo.getTopRatedMovies()).called(1);
    },
  );
}
