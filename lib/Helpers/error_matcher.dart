import 'package:code_task/Helpers/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';

///Matches for [BadRequestException]
final Matcher isBadRequestException = throwsA(isA<BadRequestException>());

///Matches for [UnauthorisedException]
final Matcher isUnauthorisedException = throwsA(isA<UnauthorisedException>());

///Matches for [FetchDataException]
final Matcher isFetchDataException = throwsA(isA<FetchDataException>());
