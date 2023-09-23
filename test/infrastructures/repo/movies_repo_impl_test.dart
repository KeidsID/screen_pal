import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal/infrastructures/repo/movies_repo_impl.dart';

import '../../helpers/dummy/dummy_movies.dart';
import '../../helpers/mocks/services/services.mocks.dart';

void main() {
  late MoviesRepoImpl subject;
  late MockDio mockDio;

  setUpAll(() {
    mockDio = MockDio();
    subject = MoviesRepoImpl(mockDio);
  });

  final expectedMovies = dummyMovieListResBody.results.map((e) {
    return e.toEntity();
  }).toList();

  final expectedMovieDetail = dummyMovieDetail;
  final expectedCollectionDetail = dummyMovieCollectionDetail;

  group('MovieRepoImpl', () {
    const apiMoviePath = '/movie';
    group('getNowPlayingMovies()', () {
      const endpoint = '$apiMoviePath/now_playing';
      test('should return list of movies', () async {
        when(mockDio.get<String>(endpoint)).thenAnswer((_) async {
          return Response<String>(
            data: dummyMovieListResBodyJson,
            requestOptions: RequestOptions(),
          );
        });

        final movies = await subject.getNowPlayingMovies();

        expect(movies, expectedMovies);
        verify(mockDio.get<String>(endpoint)).called(1);
      });
    });

    group('getPopularMovies()', () {
      const endpoint = '$apiMoviePath/popular';
      test('should return list of movies', () async {
        when(mockDio.get<String>(endpoint)).thenAnswer((_) async {
          return Response<String>(
            data: dummyMovieListResBodyJson,
            requestOptions: RequestOptions(),
          );
        });

        final movies = await subject.getPopularMovies();

        expect(movies, expectedMovies);
        verify(mockDio.get<String>(endpoint)).called(1);
      });
    });

    group('getTopRatedMovies()', () {
      const endpoint = '$apiMoviePath/top_rated';
      test('should return list of movies', () async {
        when(mockDio.get<String>(endpoint)).thenAnswer((_) async {
          return Response<String>(
            data: dummyMovieListResBodyJson,
            requestOptions: RequestOptions(),
          );
        });

        final movies = await subject.getTopRatedMovies();

        expect(movies, expectedMovies);
        verify(mockDio.get<String>(endpoint)).called(1);
      });
    });

    group('getUpcomingMovies()', () {
      const endpoint = '$apiMoviePath/upcoming';
      test('should return list of movies', () async {
        when(mockDio.get<String>(endpoint)).thenAnswer((_) async {
          return Response<String>(
            data: dummyMovieListResBodyJson,
            requestOptions: RequestOptions(),
          );
        });

        final movies = await subject.getUpcomingMovies();

        expect(movies, expectedMovies);
        verify(mockDio.get<String>(endpoint)).called(1);
      });
    });

    group('getMovieDetail()', () {
      const movieId = 123;
      const endpoint = '$apiMoviePath/$movieId';
      test('should return movie detail', () async {
        when(mockDio.get<String>(endpoint)).thenAnswer((_) async {
          return Response<String>(
            data: dummyRawMovieDetailJson,
            requestOptions: RequestOptions(),
          );
        });

        final movie = await subject.getMovieDetail(movieId);

        expect(movie, expectedMovieDetail);
        verify(mockDio.get<String>(endpoint)).called(1);
      });
    });

    group('getRecommendations()', () {
      const movieId = 123;
      const endpoint = '$apiMoviePath/$movieId/recommendations';
      test('should return list of movies', () async {
        when(mockDio.get<String>(endpoint)).thenAnswer((_) async {
          return Response<String>(
            data: dummyMovieListResBodyJson,
            requestOptions: RequestOptions(),
          );
        });

        final movies = await subject.getRecommendations(movieId);

        expect(movies, expectedMovies);
        verify(mockDio.get<String>(endpoint)).called(1);
      });
    });

    group('getMovieCollectionDetail()', () {
      const collectionId = 123;
      const endpoint = '/collection/$collectionId';
      test('should return movie collection detail', () async {
        when(mockDio.get<String>(endpoint)).thenAnswer((_) async {
          return Response<String>(
            data: dummyRawMovieCollectionDetailJson,
            requestOptions: RequestOptions(),
          );
        });

        final collectionDetail =
            await subject.getMovieCollectionDetail(collectionId);

        expect(collectionDetail, expectedCollectionDetail);
        verify(mockDio.get<String>(endpoint)).called(1);
      });
    });
  });
}
