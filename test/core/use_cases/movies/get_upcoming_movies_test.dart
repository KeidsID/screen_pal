import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal/core/use_cases/movies/get_upcoming_movies.dart';

import '../../../helpers/mocks/repo/repositories.mocks.dart';

void main() {
  late GetUpcomingMovies testUsecase;
  late MockMoviesRepo mockMoviesRepo;

  setUp(() {
    mockMoviesRepo = MockMoviesRepo();
    testUsecase = GetUpcomingMovies(moviesRepo: mockMoviesRepo);
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
