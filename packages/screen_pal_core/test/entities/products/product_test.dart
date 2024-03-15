import 'package:flutter_test/flutter_test.dart';
import 'package:screen_pal_core/screen_pal_core.dart';

void main() {
  test('Movie and TvShow - should equal by [id]', () {
    expect(
      const Movie(
        id: 123,
        title: 'title',
        overview: 'overview',
        language: 'language',
        genreIds: [],
        originalTitle: 'originalTitle',
        popularity: 12.13,
        voteAverage: 32.12,
        voteCount: 123,
        isAdult: false,
      ),
      const Movie(
        id: 123,
        title: 'title',
        overview: 'overview lorem ipsum',
        language: 'language',
        genreIds: [],
        originalTitle: 'originalTitle',
        popularity: 12.13,
        voteAverage: 32.12,
        voteCount: 123,
        isAdult: true,
      ),
    );

    //
    expect(
      const TvShow(
        id: 123,
        title: 'title',
        overview: 'overview',
        language: 'language',
        genreIds: [],
        originalTitle: 'originalTitle',
        popularity: 12.13,
        voteAverage: 32.12,
        voteCount: 123,
      ),
      const TvShow(
        id: 123,
        title: 'title',
        overview: 'overview lorem ipsum',
        language: 'language',
        genreIds: [],
        originalTitle: 'originalTitle',
        popularity: 12.13,
        voteAverage: 32.12,
        voteCount: 123,
      ),
    );
  });
}
