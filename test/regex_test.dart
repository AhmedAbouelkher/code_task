import 'package:flutter_test/flutter_test.dart';

import 'package:code_task/Helpers/regex.dart';

void main() {
  group("Regex Register form validation Test", () {
    test("E-mail address", () {
      final validEmail = "ahmed@mail.com";
      final invalidEmail = "ahmed@mail";

      expect(isValidEmail(validEmail), true);

      expect(isValidEmail(invalidEmail), false);
    });

    group("Password", () {
      //VALID PASSWORD: -
      //- Has 6 characters.
      //- at least one digit.
      //- at least one lower case char.
      test("Valid password with 2 lower case characters and 5 digits", () {
        expect(isValidPassword("am12345"), true);
      });

      test("Valid password with at least one lower case character", () {
        expect(isValidPassword("a123456"), true);
      });

      test("Invlaid password with no lower case characters", () {
        expect(isValidPassword("123456"), false);
      });

      test("Invlaid password with no digits", () {
        expect(isValidPassword("hellothere"), false);
      });

      test("Invlaid password with a lenth lower than 6 characters", () {
        expect(isValidPassword("hello"), false);
      });
    });
  });
}
