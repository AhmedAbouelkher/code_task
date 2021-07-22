import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import 'package:code_task/Helpers/networking.dart';

import 'error_matchers.dart';

void main() {
  group("Network Response codes validation Test", () {
    test("Success (code: 200)", () {
      final response = http.Response("Success", 200);
      expect(validateResponse(response), isZero);
    });
    test("Bad request (code: 400)", () {
      final response = http.Response("Bad request", 400);
      expect(() => validateResponse(response), isBadRequestException);
    });
    test("Unauthorised (code: 401)", () {
      final response = http.Response("Unauthorised", 401);
      expect(() => validateResponse(response), isUnauthorisedException);
    });
    test("Default error (code: 500)", () {
      final response = http.Response("", 500);
      expect(() => validateResponse(response), isFetchDataException);
    });
  });
}
