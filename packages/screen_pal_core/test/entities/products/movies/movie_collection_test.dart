import 'package:flutter_test/flutter_test.dart';
import 'package:screen_pal_core/screen_pal_core.dart';

void main() {
  test('MovieCollection - should equal by [id]', () {
    expect(
      const MovieCollection(id: 123, name: 'name'),
      const MovieCollection(id: 123, name: 'name', backdropImageUrl: 'null'),
    );
  });
}
