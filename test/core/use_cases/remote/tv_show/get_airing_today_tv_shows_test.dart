import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal/core/use_cases/remote/tv_shows/get_airing_today_tv_shows.dart';

import '../../../../helpers/dummy/dummy_tv_shows.dart';
import '../../../../helpers/mocks/internal.mocks.dart';

void main() {
  late GetAiringTodayTvShows subject;
  late MockTvShowsRepo mockTvShowsRepo;

  setUp(() {
    mockTvShowsRepo = MockTvShowsRepo();
    subject = GetAiringTodayTvShows(tvShowsRepo: mockTvShowsRepo);
  });

  test(
    'GetAiringTodayTvShows use case '
    'should orchestrating get airing today tv shows action correctly',
    () async {
      when(mockTvShowsRepo.getAiringTodayTvShows())
          .thenAnswer((_) async => [dummyTvShow]);

      final tvShows = await subject.execute();

      expect(tvShows, [dummyTvShow]);
      verify(mockTvShowsRepo.getAiringTodayTvShows()).called(1);
    },
  );
}
