import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal_core/screen_pal_core.dart';
import '../../../helpers/dummies/extras_dummy.dart';
import '../../../helpers/mocks/internal.mocks.dart';

void main() {
  late GetMovieGenresCase subject;
  late MockExtrasRepo mockExtrasRepo;

  setUp(() {
    mockExtrasRepo = MockExtrasRepo();
    subject = GetMovieGenresCase(extrasRepo: mockExtrasRepo);
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
