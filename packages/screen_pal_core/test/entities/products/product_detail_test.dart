import 'package:flutter_test/flutter_test.dart';
import 'package:screen_pal_core/screen_pal_core.dart';

void main() {
  test('MovieDetail and TvShowDetail - should equal by [id]', () {
    expect(
      const MovieDetail(
        id: 123,
        title: 'title',
        originalTitle: 'originalTitle',
        overview: 'overview',
        language: 'language',
        languages: [],
        genres: [],
        adult: false,
        status: 'status',
        tagline: 'tagline',
        popularity: 12,
        voteAverage: 21,
        voteCount: 321,
        budget: 12345,
        revenue: 54321,
        video: false,
      ),
      const MovieDetail(
        id: 123,
        title: 'title',
        originalTitle: 'originalTitle',
        overview: 'overview lorem ipsum',
        language: 'language',
        languages: [],
        genres: [],
        adult: false,
        status: 'status',
        tagline: 'tagline',
        popularity: 12,
        voteAverage: 21,
        voteCount: 321,
        budget: 12345,
        revenue: 54321,
        video: true,
      ),
    );

    //
    expect(
      const TvShowDetail(
        id: 123,
        title: 'title',
        originalTitle: 'originalTitle',
        overview: 'overview',
        language: 'language',
        languages: [],
        genres: [],
        adult: false,
        status: 'status',
        tagline: 'tagline',
        popularity: 12,
        voteAverage: 21,
        voteCount: 321,
        type: 'type',
        seasons: [],
        seasonCount: 0,
        episodeCount: 0,
      ),
      const TvShowDetail(
        id: 123,
        title: 'title',
        originalTitle: 'originalTitle',
        overview: 'overview lorem ipsum',
        language: 'language',
        languages: [],
        genres: [],
        adult: true,
        status: 'status',
        tagline: 'tagline',
        popularity: 12,
        voteAverage: 21,
        voteCount: 321,
        type: 'type',
        seasons: [],
        seasonCount: 0,
        episodeCount: 0,
      ),
    );
  });
}
