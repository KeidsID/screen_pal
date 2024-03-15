import 'package:flutter_test/flutter_test.dart';
import 'package:screen_pal_core/screen_pal_core.dart';

void main() {
  test(
    'Season - should equal by id',
    () {
      expect(
        const Season(
          id: 123,
          seasonNumber: 1,
          name: 'name',
          overview: 'overview',
          episodeCount: 0,
          voteAverage: 123,
        ),
        const Season(
          id: 123,
          seasonNumber: 2,
          name: 'name lorem ipsum',
          overview: 'overview',
          episodeCount: 0,
          voteAverage: 123,
        ),
      );
    },
  );
}
