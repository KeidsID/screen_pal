import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal/core/use_cases/movie/get_popular_movies.dart';

import '../../../helpers/mocks/repo/repositories.mocks.dart';

void main() {
  late GetPopularMovies testUsecase;
  late MockMoviesRepo mockMoviesRepo;

  setUp(() {
    mockMoviesRepo = MockMoviesRepo();
    testUsecase = GetPopularMovies(moviesRepo: mockMoviesRepo);
  });

  test(
    'GetPopularMovie use case should orchestrating get now playing movies action correctly',
    () async {
      when(mockMoviesRepo.getPopularMovies()).thenAnswer((_) async => []);

      final movies = await testUsecase.execute();

      expect(movies, []);
      verify(mockMoviesRepo.getPopularMovies()).called(1);
    },
  );
}
