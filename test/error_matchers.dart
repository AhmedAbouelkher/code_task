import 'package:flutter_test/flutter_test.dart';

import 'package:code_task/Helpers/exceptions.dart';

///Matches for [BadRequestException]
final Matcher isBadRequestException = throwsA(isA<BadRequestException>());

///Matches for [UnauthorisedException]
final Matcher isUnauthorisedException = throwsA(isA<UnauthorisedException>());

///Matches for [FetchDataException]
final Matcher isFetchDataException = throwsA(isA<FetchDataException>());

///Matches for [FetchDataException]
final Matcher isPreferenceUtilsNotIntializedException = throwsA(isA<PreferenceUtilsNotIntializedException>());

///Matches for [NotSupportedTypeToSaveException]
final Matcher isNotSupportedTypeToSaveException = throwsA(isA<NotSupportedTypeToSaveException>());
