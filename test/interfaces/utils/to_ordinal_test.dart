import 'package:flutter_test/flutter_test.dart';

import 'package:screen_pal/interfaces/utils/to_ordinal.dart';

void main() {
  group('toOrdinal extension on int', () {
    test('should throw FormatException if the value are below 1', () {
      expect(() => 0.toOrdinal(), throwsA(isA<FormatException>()));
      expect(() => (-1).toOrdinal(), throwsA(isA<FormatException>()));
      expect(() => (-2).toOrdinal(), throwsA(isA<FormatException>()));
      expect(() => (-3).toOrdinal(), throwsA(isA<FormatException>()));
      expect(() => (-4).toOrdinal(), throwsA(isA<FormatException>()));
    });
    test('should return ordinal format of the value', () {
      expect(1.toOrdinal(), '1st');
      expect(2.toOrdinal(), '2nd');
      expect(3.toOrdinal(), '3rd');
      expect(4.toOrdinal(), '4th');
      expect(5.toOrdinal(), '5th');

      expect(11.toOrdinal(), '11th');
      expect(12.toOrdinal(), '12th');
      expect(13.toOrdinal(), '13th');
      expect(14.toOrdinal(), '14th');
      expect(15.toOrdinal(), '15th');

      expect(21.toOrdinal(), '21st');
      expect(22.toOrdinal(), '22nd');
      expect(23.toOrdinal(), '23rd');
      expect(24.toOrdinal(), '24th');
      expect(25.toOrdinal(), '25th');

      expect(31.toOrdinal(), '31st');
      expect(32.toOrdinal(), '32nd');
      expect(33.toOrdinal(), '33rd');
      expect(34.toOrdinal(), '34th');
      expect(35.toOrdinal(), '35th');
    });
  });
}
