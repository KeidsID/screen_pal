import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal/core/use_cases/tv_shows/get_popular_tv_shows.dart';

import '../../../helpers/dummy/dummy_tv_shows.dart';
import '../../../helpers/mocks/repositories.mocks.dart';

void main() {
  late GetPopularTvShows subject;
  late MockTvShowsRepo mockTvShowsRepo;

  setUp(() {
    mockTvShowsRepo = MockTvShowsRepo();
    subject = GetPopularTvShows(tvShowsRepo: mockTvShowsRepo);
  });

  test(
    'GetPopularTvShows use case '
    'should orchestrating get popular tv shows action correctly',
    () async {
      when(mockTvShowsRepo.getPopularTvShows())
          .thenAnswer((_) async => [dummyTvShow]);

      final tvShows = await subject.execute();

      expect(tvShows, [dummyTvShow]);
      verify(mockTvShowsRepo.getPopularTvShows()).called(1);
    },
  );
}
