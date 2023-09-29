import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal/core/use_cases/tv_shows/get_on_air_tv_shows.dart';

import '../../../helpers/dummy/dummy_tv_shows.dart';
import '../../../helpers/mocks/repositories.mocks.dart';

void main() {
  late GetOnAirTvShows subject;
  late MockTvShowsRepo mockTvShowsRepo;

  setUp(() {
    mockTvShowsRepo = MockTvShowsRepo();
    subject = GetOnAirTvShows(mockTvShowsRepo);
  });

  test(
    'GetOnAirTvShows use case '
    'should orchestrating get on air tv shows action correctly',
    () async {
      when(mockTvShowsRepo.getOnAirTvShows())
          .thenAnswer((_) async => [dummyTvShow]);

      final movies = await subject.execute();

      expect(movies, [dummyTvShow]);
      verify(mockTvShowsRepo.getOnAirTvShows()).called(1);
    },
  );
}
