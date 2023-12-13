import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal/core/use_cases/remote/movies/get_movie_collection_detail.dart';

import '../../../../helpers/dummy/dummy_movies.dart';
import '../../../../helpers/mocks/internal.mocks.dart';

void main() {
  late GetMovieCollectionDetail subject;
  late MockMoviesRepo mockMoviesRepo;

  setUp(() {
    mockMoviesRepo = MockMoviesRepo();
    subject = GetMovieCollectionDetail(moviesRepo: mockMoviesRepo);
  });

  test(
    'GetMovieCollectionDetail use case '
    'should orchestrating get movie collection detail action correctly',
    () async {
      when(mockMoviesRepo.getMovieCollectionDetail(123))
          .thenAnswer((_) async => dummyMovieCollectionDetail);

      final movies = await subject.execute(123);

      expect(movies, dummyMovieCollectionDetail);
      verify(mockMoviesRepo.getMovieCollectionDetail(123)).called(1);
    },
  );
}