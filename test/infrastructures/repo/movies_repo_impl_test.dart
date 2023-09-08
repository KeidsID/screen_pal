import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal/infrastructures/repo/movies_repo_impl.dart';

import '../../helpers/dummy/dummy_movies.dart';
import '../../helpers/mocks/services/services.mocks.dart';

void main() {
  late MoviesRepoImpl testRepoImpl;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    testRepoImpl = MoviesRepoImpl(mockDio);
  });

  final expectedMovies = dummyMovieListResBody.results.map((e) {
    return e.toEntity();
  }).toList();

  group('MovieRepoImpl', () {
    const basePath = '/movie';
    group('getNowPlayingMovies()', () {
      const endpoint = '$basePath/now_playing';
      test('should return list of movies', () async {
        when(mockDio.get<String>(endpoint)).thenAnswer((_) async {
          return Response<String>(
            data: dummyRawMovieListResBody,
            requestOptions: RequestOptions(),
          );
        });

        final movies = await testRepoImpl.getNowPlayingMovies();

        expect(movies, expectedMovies);
        verify(mockDio.get<String>(endpoint)).called(1);
      });
    });

    group('getPopularMovies()', () {
      const endpoint = '$basePath/popular';
      test('should return list of movies', () async {
        when(mockDio.get<String>(endpoint)).thenAnswer((_) async {
          return Response<String>(
            data: dummyRawMovieListResBody,
            requestOptions: RequestOptions(),
          );
        });

        final movies = await testRepoImpl.getPopularMovies();

        expect(movies, expectedMovies);
        verify(mockDio.get<String>(endpoint)).called(1);
      });
    });

    group('getTopRatedMovies()', () {
      const endpoint = '$basePath/top_rated';
      test('should return list of movies', () async {
        when(mockDio.get<String>(endpoint)).thenAnswer((_) async {
          return Response<String>(
            data: dummyRawMovieListResBody,
            requestOptions: RequestOptions(),
          );
        });

        final movies = await testRepoImpl.getTopRatedMovies();

        expect(movies, expectedMovies);
        verify(mockDio.get<String>(endpoint)).called(1);
      });
    });

    group('getUpcomingMovies()', () {
      const endpoint = '$basePath/upcoming';
      test('should return list of movies', () async {
        when(mockDio.get<String>(endpoint)).thenAnswer((_) async {
          return Response<String>(
            data: dummyRawMovieListResBody,
            requestOptions: RequestOptions(),
          );
        });

        final movies = await testRepoImpl.getUpcomingMovies();

        expect(movies, expectedMovies);
        verify(mockDio.get<String>(endpoint)).called(1);
      });
    });
  });
}
