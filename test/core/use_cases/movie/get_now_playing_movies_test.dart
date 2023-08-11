import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal/core/use_cases/movie/get_now_playing_movies.dart';

import '../../../mocks/repo/repositories.mocks.dart';

void main() {
  late GetNowPlayingMovies testUsecase;
  late MockMovieRepo mockMovieRepo;

  setUp(() {
    mockMovieRepo = MockMovieRepo();
    testUsecase = GetNowPlayingMovies(movieRepo: mockMovieRepo);
  });

  test(
    'GetNowPlayingMovie use case should orchestrating get now playing movies action correctly',
    () async {
      when(mockMovieRepo.getNowPlayingMovies()).thenAnswer((_) async => []);

      final movies = await testUsecase.execute();

      expect(movies, []);
      verify(mockMovieRepo.getNowPlayingMovies()).called(1);
    },
  );
}
