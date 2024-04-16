import 'package:flutter_test/flutter_test.dart';

// test to check whether the conversion works properly
void main() {
  group('TimeUtils', () {
    test('converts total seconds to hours and minutes correctly', () {
      var result = TimeUtils.convertSecondsToHoursMinutes(3661);
      expect(result['hours'], 1);
      expect(result['minutes'], 1);
    });

    test('handles zero seconds correctly', () {
      var result = TimeUtils.convertSecondsToHoursMinutes(0);
      expect(result['hours'], 0);
      expect(result['minutes'], 0);
    });

    test('rounds down minutes correctly', () {
      var result = TimeUtils.convertSecondsToHoursMinutes(3500);
      expect(result['hours'], 0);
      expect(result['minutes'], 58);
    });
  });
}

class TimeUtils {
  static Map<String, int> convertSecondsToHoursMinutes(int totalSeconds) {
    int hours = totalSeconds ~/ 3600;
    int minutes = (totalSeconds % 3600) ~/ 60;
    return {'hours': hours, 'minutes': minutes};
  }
}
