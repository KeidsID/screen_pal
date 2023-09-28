import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal/core/use_cases/extras/get_languages.dart';

import '../../../helpers/dummy/dummy_languages.dart';
import '../../../helpers/mocks/repositories.mocks.dart';

void main() {
  late GetLanguages subject;
  late MockExtrasRepo mockExtrasRepo;

  setUp(() {
    mockExtrasRepo = MockExtrasRepo();
    subject = GetLanguages(extrasRepo: mockExtrasRepo);
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
