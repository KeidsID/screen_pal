import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal_core/screen_pal_core.dart';
import '../../../helpers/dummies/tv_show_dummies.dart';
import '../../../helpers/mocks/internal.mocks.dart';

void main() {
  late GetTopRatedTvShowsCase subject;
  late MockTvShowsRepo mockTvShowsRepo;

  setUp(() {
    mockTvShowsRepo = MockTvShowsRepo();
    subject = GetTopRatedTvShowsCase(tvShowsRepo: mockTvShowsRepo);
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
