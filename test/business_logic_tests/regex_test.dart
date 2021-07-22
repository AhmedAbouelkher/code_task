import 'package:flutter_test/flutter_test.dart';

import 'package:code_task/Helpers/regex.dart';

void main() {
  group("Regex Register form validation Test", () {
    test("E-mail Address", () {
      //Valid E-mail
      expect(isValidEmail("username@mail.com"), isTrue);

      //Invalid with Domain
      expect(isValidEmail("username@mail"), isFalse);

      //nvalid with Username
      expect(isValidEmail("username"), isFalse);
    });

    test("Password", () {
      //VALID PASSWORD: -
      //- Has 6 characters.
      //- at least one digit.
      //- at least one lower case char.

      //Valid password with 2 lower case characters and 5 digits
      expect(isValidPassword("am12345"), isTrue);

      //Valid password with at least one lower case character
      expect(isValidPassword("a123456"), isTrue);

      //Invlaid password with no lower case characters
      expect(isValidPassword("123456"), isFalse);

      //Invlaid password with no digits
      expect(isValidPassword("hellothere"), isFalse);

      //Invlaid password with a lenth lower than 6 characters
      expect(isValidPassword("hello"), isFalse);
    });
  });
}
