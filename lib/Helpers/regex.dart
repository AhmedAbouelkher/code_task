///Checks if the given E-mail is valid.
bool isValidEmail(String? value) {
  if (value == null) return false;
  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
}

///Checks if the given password is valid based on the below rules.
///```
///
///Password available regex: -
/// r'^
///   (?=.*[A-Z])       // should contain at least one upper case
///   (?=.*[a-z])       // should contain at least one lower case
///   (?=.*?[0-9])      // should contain at least one digit
///   (?=.*?[!@#\$&*~]) // should contain at least one Special character
///   .{8,}             // Must be at least 8 characters in length
/// $
/// ```
bool isValidPassword(String? value) {
  if (value == null) return false;
  return RegExp(r'^.{6,}$').hasMatch(value);
}
