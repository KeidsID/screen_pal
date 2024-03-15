import 'package:flutter_test/flutter_test.dart';
import 'package:screen_pal_core/screen_pal_core.dart';

void main() {
  test(
    'Episode - should equal by id',
    () {
      expect(
        const Episode(
          id: 123,
          seasonNumber: 1,
          name: 'name',
          overview: 'overview',
          episodeNumber: 1,
          episodeType: 'episodeType',
          voteCount: 2024,
          voteAverage: 32.12,
          showId: 12345,
        ),
        const Episode(
          id: 123,
          seasonNumber: 2,
          name: 'name lorem ipsum',
          overview: 'overview',
          episodeNumber: 1,
          episodeType: 'episodeType',
          voteCount: 2024,
          voteAverage: 32.12,
          showId: 12345,
        ),
      );
    },
  );
}
