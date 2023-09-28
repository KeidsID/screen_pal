import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal/core/use_cases/movies/get_movie_recommendations.dart';

import '../../../helpers/dummy/dummy_movies.dart';
import '../../../helpers/mocks/repositories.mocks.dart';

void main() {
  late GetMovieRecommendations subject;
  late MockMoviesRepo mockMoviesRepo;

  setUp(() {
    mockMoviesRepo = MockMoviesRepo();
    subject = GetMovieRecommendations(moviesRepo: mockMoviesRepo);
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
