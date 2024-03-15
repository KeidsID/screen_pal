import 'package:flutter_test/flutter_test.dart';
import 'package:screen_pal_core/screen_pal_core.dart';

void main() {
  test('TvCast - should equal by id', () {
    expect(
      const TvCast(
        id: 123,
        name: 'name',
        gender: Gender.male,
        originalName: 'originalName',
        knownForDepartment: 'knownForDepartment',
        adult: false,
        popularity: 13.12,
        roles: [],
        totalEpisodeCount: 0,
      ),
      const TvCast(
        id: 123,
        name: 'name',
        gender: Gender.female,
        originalName: 'originalName',
        knownForDepartment: 'knownForDepartment',
        adult: false,
        popularity: 13.12,
        roles: [],
        totalEpisodeCount: 0,
      ),
    );
  });

  test('TvCrew - should equal by id', () {
    expect(
      const TvCrew(
        id: 123,
        name: 'name',
        gender: Gender.male,
        originalName: 'originalName',
        knownForDepartment: 'knownForDepartment',
        department: 'department',
        adult: false,
        popularity: 13.12,
        roles: [],
        totalEpisodeCount: 0,
      ),
      const TvCrew(
        id: 123,
        name: 'name',
        gender: Gender.female,
        originalName: 'originalName',
        knownForDepartment: 'knownForDepartment',
        department: 'department',
        adult: false,
        popularity: 13.12,
        roles: [],
        totalEpisodeCount: 0,
      ),
    );
  });

  test(
    'TvCast.mainRole - should return the first role of [roles]. Return "?" if [roles] is empty',
    () {
      expect(
        const TvCast(
          id: 123,
          name: 'name',
          gender: Gender.male,
          originalName: 'originalName',
          knownForDepartment: 'knownForDepartment',
          adult: false,
          popularity: 13.12,
          roles: [],
          totalEpisodeCount: 0,
        ).mainRole,
        '?',
      );
      expect(
        const TvCast(
          id: 123,
          name: 'name',
          gender: Gender.male,
          originalName: 'originalName',
          knownForDepartment: 'knownForDepartment',
          adult: false,
          popularity: 13.12,
          roles: [
            TvCastRole(
              creditId: '123',
              episodeCount: 0,
              character: 'character',
            )
          ],
          totalEpisodeCount: 0,
        ).mainRole,
        'character',
      );
      
    },
  );

  test(
    'TvCrew.mainRole - should return the first role of [roles]. Return "?" if [roles] is empty',
    () {
      expect(
        const TvCrew(
          id: 123,
          name: 'name',
          gender: Gender.male,
          originalName: 'originalName',
          knownForDepartment: 'knownForDepartment',
          department: 'department',
          adult: false,
          popularity: 13.12,
          roles: [],
          totalEpisodeCount: 0,
        ).mainRole,
        '?',
      );
      expect(
        const TvCrew(
          id: 123,
          name: 'name',
          gender: Gender.male,
          originalName: 'originalName',
          knownForDepartment: 'knownForDepartment',
          department: 'department',
          adult: false,
          popularity: 13.12,
          roles: [
            TvCrewRole(creditId: '123', episodeCount: 0, job: 'job'),
          ],
          totalEpisodeCount: 0,
        ).mainRole,
        'job',
      );
    },
  );
}
