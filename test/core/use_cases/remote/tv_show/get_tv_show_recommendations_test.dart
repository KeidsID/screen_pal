import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal/core/use_cases/remote/tv_shows/get_tv_show_recommendations.dart';

import '../../../../helpers/dummy/dummy_tv_shows.dart';
import '../../../../helpers/mocks/internal.mocks.dart';

void main() {
  late GetTvShowRecommendations subject;
  late MockTvShowsRepo mockTvShowsRepo;

  setUp(() {
    mockTvShowsRepo = MockTvShowsRepo();
    subject = GetTvShowRecommendations(tvShowsRepo: mockTvShowsRepo);
  });

  test(
    'GetTvShowRecommendations use case '
    'should orchestrating get tv show recommendations action correctly',
    () async {
      when(mockTvShowsRepo.getTvShowRecommendations(123))
          .thenAnswer((_) async => [dummyTvShow]);

      final tvShows = await subject.execute(123);

      expect(tvShows, [dummyTvShow]);
      verify(mockTvShowsRepo.getTvShowRecommendations(123)).called(1);
    },
  );
}
