///Checks if the given E-mail is valid.
bool isValidEmail(String? value) {
  if (value == null) return false;
  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
}

///Checks if the given password is valid based on the below rules.
///
///Rules:
///* At least 6 characters.
///* At least one lower case Character.
///* At least one digit.
///
bool isValidPassword(String? value) {
  if (value == null) return false;
  return RegExp(r'^(?=.*[a-z])(?=.*?[0-9]).{6,}$').hasMatch(value);
}
