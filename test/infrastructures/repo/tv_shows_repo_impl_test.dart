import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal/infrastructures/repo/tv_shows_repo_impl.dart';

import '../../helpers/dummy/dummy_credits.dart';
import '../../helpers/dummy/dummy_tv_shows.dart';
import '../../helpers/mocks/services.mocks.dart';

void main() {
  late TvShowsRepoImpl subject;
  late MockDio mockDio;

  setUpAll(() {
    mockDio = MockDio();
    subject = TvShowsRepoImpl(mockDio);
  });

  final expectedTvShows = dummyTvShowListResBody.results.map((e) {
    return e.toEntity();
  }).toList();

  group('TvShowsRepoImpl', () {
    const tvShowsPath = '/tv';
    group('getAiringTodayTvShows()', () {
      const endpoint = '$tvShowsPath/airing_today';
      test('should return list of tv show', () async {
        when(mockDio.get<String>(endpoint)).thenAnswer((_) async {
          return Response<String>(
            data: dummyTvShowListResBodyJson,
            requestOptions: RequestOptions(),
          );
        });

        final tvShows = await subject.getAiringTodayTvShows();

        expect(tvShows, expectedTvShows);
        verify(mockDio.get<String>(endpoint)).called(1);
      });
    });

    group('getOnAirTvShows()', () {
      const endpoint = '$tvShowsPath/on_the_air';
      test('should return list of tv show', () async {
        when(mockDio.get<String>(endpoint)).thenAnswer((_) async {
          return Response<String>(
            data: dummyTvShowListResBodyJson,
            requestOptions: RequestOptions(),
          );
        });

        final tvShows = await subject.getOnAirTvShows();

        expect(tvShows, expectedTvShows);
        verify(mockDio.get<String>(endpoint)).called(1);
      });
    });

    group('getPopularTvShows()', () {
      const endpoint = '$tvShowsPath/popular';
      test('should return list of tv show', () async {
        when(mockDio.get<String>(endpoint)).thenAnswer((_) async {
          return Response<String>(
            data: dummyTvShowListResBodyJson,
            requestOptions: RequestOptions(),
          );
        });

        final tvShows = await subject.getPopularTvShows();

        expect(tvShows, expectedTvShows);
        verify(mockDio.get<String>(endpoint)).called(1);
      });
    });

    group('getTopRatedTvShows()', () {
      const endpoint = '$tvShowsPath/top_rated';
      test('should return list of tv show', () async {
        when(mockDio.get<String>(endpoint)).thenAnswer((_) async {
          return Response<String>(
            data: dummyTvShowListResBodyJson,
            requestOptions: RequestOptions(),
          );
        });

        final tvShows = await subject.getTopRatedTvShows();

        expect(tvShows, expectedTvShows);
        verify(mockDio.get<String>(endpoint)).called(1);
      });
    });

    group('getTvShowDetail()', () {
      const endpoint = '$tvShowsPath/123';
      test('should return tv show detail', () async {
        when(mockDio.get<String>(endpoint)).thenAnswer((_) async {
          return Response<String>(
            data: dummyRawTvShowDetailJson,
            requestOptions: RequestOptions(),
          );
        });

        final tvShows = await subject.getTvShowDetail(123);

        expect(tvShows, dummyTvShowDetail);
        verify(mockDio.get<String>(endpoint)).called(1);
      });
    });

    group('getTvShowRecommendations()', () {
      const endpoint = '$tvShowsPath/123/recommendations';
      test('should return list of tv show', () async {
        when(mockDio.get<String>(endpoint)).thenAnswer((_) async {
          return Response<String>(
            data: dummyTvShowListResBodyJson,
            requestOptions: RequestOptions(),
          );
        });

        final tvShows = await subject.getTvShowRecommendations(123);

        expect(tvShows, expectedTvShows);
        verify(mockDio.get<String>(endpoint)).called(1);
      });
    });

    group('getTvShowCredits()', () {
      const tvShowId = 123;
      const endpoint = '/tv/$tvShowId/credits';

      test('should return credits of the movie', () async {
        when(mockDio.get<String>(endpoint)).thenAnswer((_) async {
          return Response<String>(
            requestOptions: RequestOptions(),
            data: dummyRawTvShowCreditsJson,
          );
        });

        final credits = await subject.getTvShowCredits(tvShowId);

        verify(mockDio.get<String>(endpoint)).called(1);
        expect(credits, dummyTvShowCredits);
      });
    });
  });
}
