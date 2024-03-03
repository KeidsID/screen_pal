import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal/core/use_cases/remote/movies/get_movie_recommendations_case.dart';

import '../../../../helpers/dummy/dummy_movies.dart';
import '../../../../helpers/mocks/internal.mocks.dart';

void main() {
  late GetMovieRecommendationsCase subject;
  late MockMoviesRepo mockMoviesRepo;

  setUp(() {
    mockMoviesRepo = MockMoviesRepo();
    subject = GetMovieRecommendationsCase(moviesRepo: mockMoviesRepo);
  });

  test(
    'GetMovieRecommendations use case '
    'should orchestrating get movie recommendations action correctly',
    () async {
      when(mockMoviesRepo.getRecommendations(123))
          .thenAnswer((_) async => [dummyMovie]);

      final movies = await subject.execute(123);

      expect(movies, [dummyMovie]);
      verify(mockMoviesRepo.getRecommendations(123)).called(1);
    },
  );
}