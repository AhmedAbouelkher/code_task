import 'package:flutter_test/flutter_test.dart';

import 'package:code_task/Helpers/regex.dart';

void main() {
  group("Regex Register form validation Test", () {
    group("E-mail Address", () {
      test("Valid E-mail", () {
        final validEmail = "username@mail.com";
        expect(isValidEmail(validEmail), isTrue);
      });

      test("Invalid with Domain", () {
        final invalidEmail = "username@mail";
        expect(isValidEmail(invalidEmail), isFalse);
      });

      test("Invalid with Username", () {
        final invalidEmail = "username";
        expect(isValidEmail(invalidEmail), isFalse);
      });
    });

    group("Password", () {
      //VALID PASSWORD: -
      //- Has 6 characters.
      //- at least one digit.
      //- at least one lower case char.
      test("Valid password with 2 lower case characters and 5 digits", () {
        expect(isValidPassword("am12345"), isTrue);
      });

      test("Valid password with at least one lower case character", () {
        expect(isValidPassword("a123456"), isTrue);
      });

      test("Invlaid password with no lower case characters", () {
        expect(isValidPassword("123456"), isFalse);
      });

      test("Invlaid password with no digits", () {
        expect(isValidPassword("hellothere"), isFalse);
      });

      test("Invlaid password with a lenth lower than 6 characters", () {
        expect(isValidPassword("hello"), isFalse);
      });
    });
  });
}
