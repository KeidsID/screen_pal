import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal/core/use_cases/extras/get_tv_show_genres.dart';

import '../../../helpers/dummy/dummy_genres.dart';
import '../../../helpers/mocks/repositories.mocks.dart';

void main() {
  late GetTvShowGenres subject;
  late MockExtrasRepo mockExtrasRepo;

  setUp(() {
    mockExtrasRepo = MockExtrasRepo();
    subject = GetTvShowGenres(extrasRepo: mockExtrasRepo);
  });

  test(
    'GetTvShowGenres use case should orchestrating get genres action correctly',
    () async {
      when(mockExtrasRepo.getTvShowGenres())
          .thenAnswer((_) async => dummyGenres);

      final genres = await subject.execute();

      expect(genres, dummyGenres);
      verify(mockExtrasRepo.getTvShowGenres()).called(1);
    },
  );
}
