import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal_core/screen_pal_core.dart';
import '../../../helpers/dummies/tv_show_dummies.dart';
import '../../../helpers/mocks/internal.mocks.dart';

void main() {
  late GetPopularTvShowsCase subject;
  late MockTvShowsRepo mockTvShowsRepo;

  setUp(() {
    mockTvShowsRepo = MockTvShowsRepo();
    subject = GetPopularTvShowsCase(tvShowsRepo: mockTvShowsRepo);
  });

  test(
    'GetPopularTvShowsCase - should orchestrating get popular tv shows action correctly',
    () async {
      when(mockTvShowsRepo.getPopularTvShows())
          .thenAnswer((_) async => [dummyTvShow]);

      final tvShows = await subject.execute();

      expect(tvShows, [dummyTvShow]);
      verify(mockTvShowsRepo.getPopularTvShows()).called(1);
    },
  );
}
