import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal/core/use_cases/remote/tv_shows/get_tv_show_detail.dart';

import '../../../../helpers/dummy/dummy_tv_shows.dart';
import '../../../../helpers/mocks/internal.mocks.dart';

void main() {
  late GetTvShowDetail subject;
  late MockTvShowsRepo mockTvShowsRepo;

  setUp(() {
    mockTvShowsRepo = MockTvShowsRepo();
    subject = GetTvShowDetail(tvShowsRepo: mockTvShowsRepo);
  });

  test(
    'GetTvShowDetail use case '
    'should orchestrating get tv show detail action correctly',
    () async {
      provideDummy(dummyTvShowDetail); // mockito helper

      when(mockTvShowsRepo.getTvShowDetail(123))
          .thenAnswer((_) async => dummyTvShowDetail);

      final tvShow = await subject.execute(123);

      expect(tvShow, dummyTvShowDetail);
      verify(mockTvShowsRepo.getTvShowDetail(123)).called(1);
    },
  );
}
