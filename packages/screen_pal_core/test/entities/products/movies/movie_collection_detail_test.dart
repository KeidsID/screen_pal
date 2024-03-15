import 'package:flutter_test/flutter_test.dart';
import 'package:screen_pal_core/screen_pal_core.dart';

void main() {
  test(
    'MovieCollectionDetail - should equal by id',
    () {
      expect(
        const MovieCollectionDetail(
          id: 1,
          name: 'name',
          overview: 'overview',
          parts: [],
        ),
        const MovieCollectionDetail(
          id: 1,
          name: 'name',
          overview: 'overview lorem ipsum',
          parts: [],
        ),
      );
    },
  );
}
