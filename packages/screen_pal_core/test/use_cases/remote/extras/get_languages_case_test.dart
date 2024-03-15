import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:screen_pal_core/screen_pal_core.dart';
import '../../../helpers/dummies/extras_dummy.dart';
import '../../../helpers/mocks/internal.mocks.dart';

void main() {
  late GetLanguagesCase subject;
  late MockExtrasRepo mockExtrasRepo;

  setUp(() {
    mockExtrasRepo = MockExtrasRepo();
    subject = GetLanguagesCase(extrasRepo: mockExtrasRepo);
  });

  test(
    'GetLanguagesCase - should orchestrating get languages action correctly',
    () async {
      when(mockExtrasRepo.getLanguages())
          .thenAnswer((_) async => dummyLanguages);

      final languages = await subject.execute();

      expect(languages, dummyLanguages);
      verify(mockExtrasRepo.getLanguages()).called(1);
    },
  );
}
