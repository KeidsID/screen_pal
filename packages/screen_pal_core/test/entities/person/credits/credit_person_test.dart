import 'package:flutter_test/flutter_test.dart';
import 'package:screen_pal_core/screen_pal_core.dart';

void main() {
  test('Cast - should equal by id', () {
    expect(
      const Cast(
        id: 123,
        name: 'name',
        gender: Gender.male,
        originalName: 'originalName',
        knownForDepartment: 'knownForDepartment',
        adult: false,
        popularity: 13.12,
        character: 'Walter White',
      ),
      const Cast(
        id: 123,
        name: 'name',
        gender: Gender.male,
        originalName: 'originalName',
        knownForDepartment: 'knownForDepartment',
        adult: false,
        popularity: 13.12,
        character: 'Jesse Pinkman',
      ),
    );
  });

  test('Crew - should equal by id', () {
    expect(
      const Crew(
        id: 123,
        name: 'name',
        gender: Gender.male,
        originalName: 'originalName',
        knownForDepartment: 'knownForDepartment',
        adult: false,
        popularity: 13.12,
        job: 'Producer',
      ),
      const Crew(
        id: 123,
        name: 'name',
        gender: Gender.male,
        originalName: 'originalName',
        knownForDepartment: 'knownForDepartment',
        adult: false,
        popularity: 13.12,
        job: 'Director',
      ),
    );
  });

  test(
    'Cast.mainRole - should return [character]. Return "?" if [character] is empty string.',
    () {
      expect(
        const Cast(
          id: 123,
          name: 'name',
          gender: Gender.male,
          originalName: 'originalName',
          knownForDepartment: 'knownForDepartment',
          adult: false,
          popularity: 13.12,
          character: 'Walter White',
        ).mainRole,
        'Walter White',
      );

      expect(
        const Cast(
          id: 123,
          name: 'name',
          gender: Gender.male,
          originalName: 'originalName',
          knownForDepartment: 'knownForDepartment',
          adult: false,
          popularity: 13.12,
          character: '',
        ).mainRole,
        '?',
      );
    },
  );

  test(
    'Crew.mainRole - should return [job]. Return "?" if [job] is empty string.',
    () {
      expect(
        const Crew(
          id: 123,
          name: 'name',
          gender: Gender.male,
          originalName: 'originalName',
          knownForDepartment: 'knownForDepartment',
          adult: false,
          popularity: 13.12,
          job: 'Director',
        ).mainRole,
        'Director',
      );

      expect(
        const Crew(
          id: 123,
          name: 'name',
          gender: Gender.male,
          originalName: 'originalName',
          knownForDepartment: 'knownForDepartment',
          adult: false,
          popularity: 13.12,
          job: '',
        ).mainRole,
        '?',
      );
    },
  );
}
