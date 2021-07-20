import 'package:http/http.dart' as http;

import 'exceptions.dart';

///Has all networking URIs.
class NetworkConstants {
  static const String _baseAPI = "https://run.mocky.io/v3/";

  ///User Medical Diagnosis uri
  static const String fetchUserMedicalDiagnosis = _baseAPI + "35120fb2-1183-4b6e-af59-336dab736a78";
}

///Validating newtork request and retuns `0` if successful, otherwise `throws` and exception.
int validateResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      return 0;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
