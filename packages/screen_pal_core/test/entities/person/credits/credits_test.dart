import 'package:flutter_test/flutter_test.dart';
import 'package:screen_pal_core/src/entities.dart';

void main() {
  test('Credits - should equal by [productId]', () {
    expect(
      const Credits(productId: 123, casts: [], crews: []),
      const Credits(
        productId: 123,
        casts: [
          Cast(
            id: 123,
            name: 'name',
            gender: Gender.female,
            originalName: 'originalName',
            knownForDepartment: 'knownForDepartment',
            adult: false,
            popularity: 12.13,
            character: 'character',
          ),
        ],
        crews: [],
      ),
    );
  });

  test('TvCredits - should equal by [productId]', () {
    expect(
      const TvCredits(productId: 123, casts: [], crews: []),
      const TvCredits(
        productId: 123,
        casts: [
          TvCast(
            id: 123,
            name: 'name',
            gender: Gender.female,
            originalName: 'originalName',
            knownForDepartment: 'knownForDepartment',
            adult: false,
            popularity: 12.13,
            roles: [],
            totalEpisodeCount: 0,
          ),
        ],
        crews: [],
      ),
    );
  });
}
