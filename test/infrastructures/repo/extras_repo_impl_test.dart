import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal/infrastructures/repo/extras_repo_impl.dart';

import '../../helpers/dummy/dummy_genres.dart';
import '../../helpers/dummy/dummy_languages.dart';
import '../../helpers/mocks/services.mocks.dart';

void main() {
  late ExtrasRepoImpl subject;
  late MockDio mockDio;

  setUpAll(() {
    mockDio = MockDio();
    subject = ExtrasRepoImpl(mockDio);
  });

  final expectedLanguages = dummyLanguages;
  final expectedGenres = dummyGenres;

  group('ExtrasRepoImpl', () {
    const genrePath = '/genre';
    test('getLanguages() should return list of language', () async {
      const endpoint = '/configuration/languages';

      when(mockDio.get<String>(endpoint)).thenAnswer(
        (_) async => Response<String>(
          data: dummyLanguagesJson,
          requestOptions: RequestOptions(),
        ),
      );

      final languages = await subject.getLanguages();

      expect(languages, expectedLanguages);
      verify(mockDio.get<String>(endpoint)).called(1);
    });

    test('getMovieGenres() should return list of genre', () async {
      const endpoint = '$genrePath/movie/list';

      when(mockDio.get<String>(endpoint)).thenAnswer(
        (_) async => Response<String>(
          data: dummyGenresResBodyJson,
          requestOptions: RequestOptions(),
        ),
      );

      final genres = await subject.getMovieGenres();

      expect(genres, expectedGenres);
      verify(mockDio.get<String>(endpoint)).called(1);
    });

    test('getTvShowGenres() should return list of genre', () async {
      const endpoint = '$genrePath/tv/list';

      when(mockDio.get<String>(endpoint)).thenAnswer(
        (_) async => Response<String>(
          data: dummyGenresResBodyJson,
          requestOptions: RequestOptions(),
        ),
      );

      final genres = await subject.getTvShowGenres();

      expect(genres, expectedGenres);
      verify(mockDio.get<String>(endpoint)).called(1);
    });
  });
}
