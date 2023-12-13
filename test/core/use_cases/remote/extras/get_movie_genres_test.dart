import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal/core/use_cases/remote/extras/get_movie_genres.dart';

import '../../../../helpers/dummy/dummy_genres.dart';
import '../../../../helpers/mocks/internal.mocks.dart';

void main() {
  late GetMovieGenres subject;
  late MockExtrasRepo mockExtrasRepo;

  setUp(() {
    mockExtrasRepo = MockExtrasRepo();
    subject = GetMovieGenres(extrasRepo: mockExtrasRepo);
  });

  test(
    'GetMovieGenres use case should orchestrating get genres action correctly',
    () async {
      when(mockExtrasRepo.getMovieGenres())
          .thenAnswer((_) async => dummyGenres);

      final genres = await subject.execute();

      expect(genres, dummyGenres);
      verify(mockExtrasRepo.getMovieGenres()).called(1);
    },
  );
}
