import 'package:flutter_test/flutter_test.dart';

import 'package:code_task/Helpers/time_helper.dart';

void main() {
  group("Testing user time based greeting", () {
    test("at Evening", () {
      final dateTime = DateTime(2021, 5, 3, 21);
      expect(getTimeOfTheDay(dateTime), equals("Evening"));
    });
    test("at Night", () {
      final dateTime = DateTime(2021, 10, 20, 2);
      expect(getTimeOfTheDay(dateTime), equals("Night"));
    });
    test("at Morning", () {
      final dateTime = DateTime(2021, 8, 21, 11);
      expect(getTimeOfTheDay(dateTime), equals("Morning"));
    });
    test("at Afternoon", () {
      final dateTime = DateTime(2021, 7, 4, 13);
      expect(getTimeOfTheDay(dateTime), equals("Afternoon"));
    });
  });
}
