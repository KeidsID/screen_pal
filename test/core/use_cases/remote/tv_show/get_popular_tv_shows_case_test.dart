import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal/core/use_cases/remote/tv_shows/get_popular_tv_shows_case.dart';

import '../../../../helpers/dummy/dummy_tv_shows.dart';
import '../../../../helpers/mocks/internal.mocks.dart';

void main() {
  late GetPopularTvShowsCase subject;
  late MockTvShowsRepo mockTvShowsRepo;

  setUp(() {
    mockTvShowsRepo = MockTvShowsRepo();
    subject = GetPopularTvShowsCase(tvShowsRepo: mockTvShowsRepo);
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
