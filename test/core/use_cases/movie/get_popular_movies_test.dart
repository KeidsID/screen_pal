import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal/core/use_cases/movie/get_popular_movies.dart';

import '../../../mocks/repo/repositories.mocks.dart';

void main() {
  late GetPopularMovies testUsecase;
  late MockMovieRepo mockMovieRepo;

  setUp(() {
    mockMovieRepo = MockMovieRepo();
    testUsecase = GetPopularMovies(movieRepo: mockMovieRepo);
  });

  test(
    'GetPopularMovie use case should orchestrating get now playing movies action correctly',
    () async {
      when(mockMovieRepo.getPopularMovies()).thenAnswer((_) async => []);

      final movies = await testUsecase.execute();

      expect(movies, []);
      verify(mockMovieRepo.getPopularMovies()).called(1);
    },
  );
}
