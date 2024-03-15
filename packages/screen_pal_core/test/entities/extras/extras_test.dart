import 'package:flutter_test/flutter_test.dart';
import 'package:screen_pal_core/screen_pal_core.dart';

void main() {
  test('Extras - should equal by [languages] and [genres]', () {
    expect(
      const Extras(languages: [], genres: []),
      const Extras(languages: [], genres: []),
    );

    //
    expect(
      const Extras(
        languages: [
          SpokenLanguage(
            englishName: 'English',
            iso6391: 'en',
            name: 'English',
          ),
        ],
        genres: [
          Genre(id: 123, name: 'name'),
        ],
      ),
      const Extras(
        languages: [
          SpokenLanguage(
            englishName: 'English',
            iso6391: 'en',
            name: 'English',
          ),
        ],
        genres: [
          Genre(id: 123, name: 'name'),
        ],
      ),
    );
  });

  test(
    'Extras.hasEmpty - should return true if [languages] or [genres] are empty',
    () {
      expect(
        const Extras(
          languages: [],
          genres: [Genre(id: 1, name: 'name')],
        ).hasEmpty,
        true,
      );

      expect(
        const Extras(
          languages: [
            SpokenLanguage(
              englishName: 'englishName',
              iso6391: 'iso6391',
              name: 'name',
            ),
          ],
          genres: [],
        ).hasEmpty,
        true,
      );

      expect(
        const Extras(
          languages: [
            SpokenLanguage(
              englishName: 'englishName',
              iso6391: 'iso6391',
              name: 'name',
            ),
          ],
          genres: [Genre(id: 1, name: 'name')],
        ).hasEmpty,
        false,
      );
    },
  );

  test('SpokenLanguage - should equal by [iso6391]', () {
    expect(
      const SpokenLanguage(
        iso6391: 'en',
        englishName: 'English',
        name: 'English',
      ),
      const SpokenLanguage(
        iso6391: 'en',
        englishName: 'English',
        name: 'Bahasa Inggris',
      ),
    );
  });

  test('Genre - should equal by [id]', () {
    expect(
      const Genre(id: 123, name: 'name'),
      const Genre(id: 123, name: 'uwaw'),
    );
  });
}
