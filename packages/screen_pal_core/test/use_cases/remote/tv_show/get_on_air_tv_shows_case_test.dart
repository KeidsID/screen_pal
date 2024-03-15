import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal_core/screen_pal_core.dart';
import '../../../helpers/dummies/tv_show_dummies.dart';
import '../../../helpers/mocks/internal.mocks.dart';

void main() {
  late GetOnAirTvShowsCase subject;
  late MockTvShowsRepo mockTvShowsRepo;

  setUp(() {
    mockTvShowsRepo = MockTvShowsRepo();
    subject = GetOnAirTvShowsCase(tvShowsRepo: mockTvShowsRepo);
  });

  test(
    'GetOnAirTvShowsCase - should orchestrating get on air tv shows action correctly',
    () async {
      when(mockTvShowsRepo.getOnAirTvShows())
          .thenAnswer((_) async => [dummyTvShow]);

      final tvShows = await subject.execute();

      expect(tvShows, [dummyTvShow]);
      verify(mockTvShowsRepo.getOnAirTvShows()).called(1);
    },
  );
}
