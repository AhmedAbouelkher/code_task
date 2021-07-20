import 'package:flutter_test/flutter_test.dart';

import 'package:code_task/Helpers/time_helper.dart';

void main() {
  group("Testing user time based greeting", () {
    test("at Evening", () {
      final dateTime = DateTime(2021, 1, 1, 21);
      expect(getTimeOfTheDay(dateTime), equals(TimeOfDay.evening));
    });
    test("at Night", () {
      final dateTime = DateTime(2021, 1, 1, 2);
      expect(getTimeOfTheDay(dateTime), equals(TimeOfDay.night));
    });
    test("at Morning", () {
      final dateTime = DateTime(2021, 1, 1, 11);
      expect(getTimeOfTheDay(dateTime), equals(TimeOfDay.morning));
    });
    test("at Afternoon", () {
      final dateTime = DateTime(2021, 1, 1, 13);
      expect(getTimeOfTheDay(dateTime), equals(TimeOfDay.afternoon));
    });
  });
}
