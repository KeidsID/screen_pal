import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal_core/screen_pal_core.dart';
import '../../../helpers/dummies/tv_show_dummies.dart';
import '../../../helpers/mocks/internal.mocks.dart';

void main() {
  late GetTvShowRecommendationsCase subject;
  late MockTvShowsRepo mockTvShowsRepo;

  setUp(() {
    mockTvShowsRepo = MockTvShowsRepo();
    subject = GetTvShowRecommendationsCase(tvShowsRepo: mockTvShowsRepo);
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
