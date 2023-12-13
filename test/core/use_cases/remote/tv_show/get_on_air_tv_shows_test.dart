import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal/core/use_cases/remote/tv_shows/get_on_air_tv_shows.dart';

import '../../../../helpers/dummy/dummy_tv_shows.dart';
import '../../../../helpers/mocks/internal.mocks.dart';

void main() {
  late GetOnAirTvShows subject;
  late MockTvShowsRepo mockTvShowsRepo;

  setUp(() {
    mockTvShowsRepo = MockTvShowsRepo();
    subject = GetOnAirTvShows(tvShowsRepo: mockTvShowsRepo);
  });

  test(
    'GetOnAirTvShows use case '
    'should orchestrating get on air tv shows action correctly',
    () async {
      when(mockTvShowsRepo.getOnAirTvShows())
          .thenAnswer((_) async => [dummyTvShow]);

      final tvShows = await subject.execute();

      expect(tvShows, [dummyTvShow]);
      verify(mockTvShowsRepo.getOnAirTvShows()).called(1);
    },
  );
}
