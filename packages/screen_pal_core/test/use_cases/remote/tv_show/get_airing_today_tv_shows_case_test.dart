import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal_core/screen_pal_core.dart';
import '../../../helpers/dummies/tv_show_dummies.dart';
import '../../../helpers/mocks/internal.mocks.dart';

void main() {
  late GetAiringTodayTvShowsCase subject;
  late MockTvShowsRepo mockTvShowsRepo;

  setUp(() {
    mockTvShowsRepo = MockTvShowsRepo();
    subject = GetAiringTodayTvShowsCase(tvShowsRepo: mockTvShowsRepo);
  });

  test(
    'GetAiringTodayTvShowsCase - should orchestrating get airing today tv shows action correctly',
    () async {
      when(mockTvShowsRepo.getAiringTodayTvShows())
          .thenAnswer((_) async => [dummyTvShow]);

      final tvShows = await subject.execute();

      expect(tvShows, [dummyTvShow]);
      verify(mockTvShowsRepo.getAiringTodayTvShows()).called(1);
    },
  );
}
