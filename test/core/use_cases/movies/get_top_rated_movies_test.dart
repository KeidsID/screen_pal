import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal/core/use_cases/movies/get_top_rated_movies.dart';

import '../../../helpers/mocks/repo/repositories.mocks.dart';

void main() {
  late GetTopRatedMovies testUsecase;
  late MockMoviesRepo mockMoviesRepo;

  setUp(() {
    mockMoviesRepo = MockMoviesRepo();
    testUsecase = GetTopRatedMovies(moviesRepo: mockMoviesRepo);
  });

  test(
    'GetTopRatedMovie use case should orchestrating get now playing movies action correctly',
    () async {
      when(mockMoviesRepo.getTopRatedMovies()).thenAnswer((_) async => []);

      final movies = await testUsecase.execute();

      expect(movies, []);
      verify(mockMoviesRepo.getTopRatedMovies()).called(1);
    },
  );
}
