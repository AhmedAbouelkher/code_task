///Genirec exception to catch and handle resulted errror.
class AppException implements Exception {
  final message;
  final details;

  const AppException([this.message, this.details]);

  @override
  String toString() => "message: $message -> Detials: $details";
}

class FetchDataException extends AppException {
  const FetchDataException([String? details]) : super("Error During Communication.", details);
}

class BadRequestException extends AppException {
  const BadRequestException([details]) : super("Invalid Request.", details);
}

class UnauthorisedException extends AppException {
  const UnauthorisedException([details]) : super("Unauthorised.", details);
}

///A Firebase auth exception indicats that the used password is invalid or can't be used.
///
///See also:
///- `isValidPassword(String)`
///
class WeakPasswordException extends AppException {
  const WeakPasswordException({
    String? message,
  }) : super(message ?? "The password provided is too weak.");

  @override
  String toString() => 'WeakPasswordException(message: $message)';
}

///A Firebase auth exception indicats that the used email is invalid or can't be used.
///
///See also:
///- `isValidEmail(String)`
///
class EmailAlreadyUsedException extends AppException {
  const EmailAlreadyUsedException([
    String? message,
  ]) : super(message ?? "The account already exists for that email.");

  @override
  String toString() => 'EmailAlreadyUsedException(message: $message)';
}
