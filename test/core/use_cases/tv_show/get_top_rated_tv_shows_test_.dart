import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal/core/use_cases/tv_shows/get_top_rated_tv_shows.dart';

import '../../../helpers/dummy/dummy_tv_shows.dart';
import '../../../helpers/mocks/repositories.mocks.dart';

void main() {
  late GetTopRatedTvShows subject;
  late MockTvShowsRepo mockTvShowsRepo;

  setUp(() {
    mockTvShowsRepo = MockTvShowsRepo();
    subject = GetTopRatedTvShows(tvShowsRepo: mockTvShowsRepo);
  });

  test(
    'GetTopRatedTvShows use case '
    'should orchestrating get top rated tv shows action correctly',
    () async {
      when(mockTvShowsRepo.getTopRatedTvShows())
          .thenAnswer((_) async => [dummyTvShow]);

      final tvShows = await subject.execute();

      expect(tvShows, [dummyTvShow]);
      verify(mockTvShowsRepo.getTopRatedTvShows()).called(1);
    },
  );
}