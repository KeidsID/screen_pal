import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal/core/use_cases/movie/get_upcoming_movies.dart';

import '../../../mocks/repo/repositories.mocks.dart';

void main() {
  late GetUpcomingMovies testUsecase;
  late MockMovieRepo mockMovieRepo;

  setUp(() {
    mockMovieRepo = MockMovieRepo();
    testUsecase = GetUpcomingMovies(movieRepo: mockMovieRepo);
  });

  test(
    'GetUpcomingMovie use case should orchestrating get now playing movies action correctly',
    () async {
      when(mockMovieRepo.getUpcomingMovies()).thenAnswer((_) async => []);

      final movies = await testUsecase.execute();

      expect(movies, []);
      verify(mockMovieRepo.getUpcomingMovies()).called(1);
    },
  );
}
