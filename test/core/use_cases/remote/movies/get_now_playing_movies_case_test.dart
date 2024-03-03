import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal/core/use_cases/remote/movies/get_now_playing_movies_case.dart';

import '../../../../helpers/mocks/internal.mocks.dart';

void main() {
  late GetNowPlayingMoviesCase testUsecase;
  late MockMoviesRepo mockMoviesRepo;

  setUp(() {
    mockMoviesRepo = MockMoviesRepo();
    testUsecase = GetNowPlayingMoviesCase(moviesRepo: mockMoviesRepo);
  });

  test(
    'GetNowPlayingMovie use case should orchestrating get now playing movies action correctly',
    () async {
      when(mockMoviesRepo.getNowPlayingMovies()).thenAnswer((_) async => []);

      final movies = await testUsecase.execute();

      expect(movies, []);
      verify(mockMoviesRepo.getNowPlayingMovies()).called(1);
    },
  );
}