import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal_core/screen_pal_core.dart';
import '../../../helpers/mocks/internal.mocks.dart';
void main() {
  late GetPopularMoviesCase testUsecase;
  late MockMoviesRepo mockMoviesRepo;

  setUp(() {
    mockMoviesRepo = MockMoviesRepo();
    testUsecase = GetPopularMoviesCase(moviesRepo: mockMoviesRepo);
  });

  test(
    'GetPopularMovieCase - should orchestrating get now playing movies action correctly',
    () async {
      when(mockMoviesRepo.getPopularMovies()).thenAnswer((_) async => []);

      final movies = await testUsecase.execute();

      expect(movies, []);
      verify(mockMoviesRepo.getPopularMovies()).called(1);
    },
  );
}
