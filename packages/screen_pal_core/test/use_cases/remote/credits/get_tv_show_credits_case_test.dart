import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal_core/screen_pal_core.dart';
import '../../../helpers/dummies/credits_dummy.dart';
import '../../../helpers/mocks/internal.mocks.dart';

void main() {
  late GetTvShowCreditsCase subject;
  late MockTvShowsRepo mockTvShowsRepo;

  setUp(() {
    mockTvShowsRepo = MockTvShowsRepo();
    subject = GetTvShowCreditsCase(tvShowsRepo: mockTvShowsRepo);
  });

  test(
    'GetTvShowCredits use case '
    'should orchestrating get credits action correctly',
    () async {
      provideDummy(dummyCredits); // mockito helper

      when(mockTvShowsRepo.getTvShowCredits(123))
          .thenAnswer((_) async => dummyCredits);

      final genres = await subject.execute(123);

      expect(genres, dummyCredits);
      verify(mockTvShowsRepo.getTvShowCredits(123)).called(1);
    },
  );
}
