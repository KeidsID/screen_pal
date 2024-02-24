import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal/core/use_cases/remote/extras/get_languages_case.dart';

import '../../../../helpers/dummy/dummy_languages.dart';
import '../../../../helpers/mocks/internal.mocks.dart';

void main() {
  late GetLanguagesCase subject;
  late MockExtrasRepo mockExtrasRepo;

  setUp(() {
    mockExtrasRepo = MockExtrasRepo();
    subject = GetLanguagesCase(extrasRepo: mockExtrasRepo);
  });

  test(
    'GetLanguages use case should orchestrating get languages action correctly',
    () async {
      when(mockExtrasRepo.getLanguages())
          .thenAnswer((_) async => dummyLanguages);

      final languages = await subject.execute();

      expect(languages, dummyLanguages);
      verify(mockExtrasRepo.getLanguages()).called(1);
    },
  );
}
