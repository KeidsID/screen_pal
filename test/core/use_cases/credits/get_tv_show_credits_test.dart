import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal/core/use_cases/credits/get_tv_show_credits.dart';

import '../../../helpers/dummy/dummy_credits.dart';
import '../../../helpers/mocks/repositories.mocks.dart';

void main() {
  late GetTvShowCredits subject;
  late MockTvShowsRepo mockTvShowsRepo;

  setUp(() {
    mockTvShowsRepo = MockTvShowsRepo();
    subject = GetTvShowCredits(tvShowsRepo: mockTvShowsRepo);
  });

  test(
    'GetTvShowCredits use case '
    'should orchestrating get credits action correctly',
    () async {
      when(mockTvShowsRepo.getTvShowCredits(123))
          .thenAnswer((_) async => dummyTvShowCredits);

      final genres = await subject.execute(123);

      expect(genres, dummyTvShowCredits);
      verify(mockTvShowsRepo.getTvShowCredits(123)).called(1);
    },
  );
}
