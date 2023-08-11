import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal/core/use_cases/movie/get_top_rated_movies.dart';

import '../../../mocks/repo/repositories.mocks.dart';

void main() {
  late GetTopRatedMovies testUsecase;
  late MockMovieRepo mockMovieRepo;

  setUp(() {
    mockMovieRepo = MockMovieRepo();
    testUsecase = GetTopRatedMovies(movieRepo: mockMovieRepo);
  });

  test(
    'GetTopRatedMovie use case should orchestrating get now playing movies action correctly',
    () async {
      when(mockMovieRepo.getTopRatedMovies()).thenAnswer((_) async => []);

      final movies = await testUsecase.execute();

      expect(movies, []);
      verify(mockMovieRepo.getTopRatedMovies()).called(1);
    },
  );
}
