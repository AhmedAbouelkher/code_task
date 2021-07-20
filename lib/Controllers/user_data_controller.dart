import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:code_task/Helpers/networking.dart';
import 'package:code_task/Models/user_diagnosis_models.dart';

export 'package:code_task/Models/user_diagnosis_models.dart';

///Used as to manage fetching and passing user medical infromation from the api.
///
///Used with `provider` as `ChangeNotifier` class.
///
///Always use the static mehtode `AuthController.get(BuildContext)` to get an read only instance.
class UserMedicalDiagnosisDataController extends ChangeNotifier {
  ///Retuns a read-only shared instance of the class `UserMedicalDiagnosisDataController`.
  static UserMedicalDiagnosisDataController get(BuildContext context) =>
      context.read<UserMedicalDiagnosisDataController>();

  final UserDataRepository _repository;

  ///Use only with `provider`
  UserMedicalDiagnosisDataController({
    required UserDataRepository repository,
  }) : _repository = repository;

  List<Problem>? _problems;

  ///User diagnosis problems.
  List<Problem>? get problems => _problems;

  ///Fetch all user diagnosis data.
  Future<void> fetchUserData() async {
    try {
      final _preblemsResponse = await _repository.fetchUserData();
      _problems = _preblemsResponse;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}

///API repository to connect between the controller and the API Client
class UserDataRepository {
  final UserDataAPIClient _apiClient;
  UserDataRepository({
    required UserDataAPIClient apiClient,
  }) : _apiClient = apiClient;

  ///Fetch all user's diagnosis data.
  Future<List<Problem>?> fetchUserData() async {
    try {
      final _result = await _apiClient.fetchUserData();
      return UserProblemsResponse.fromJson(_result).problems;
    } catch (_) {
      rethrow;
    }
  }
}

//API Client
class UserDataAPIClient {
  Future fetchUserData() async {
    final _response = await http.get(
      Uri.parse(NetworkConstants.fetchUserMedicalDiagnosis),
      headers: {
        "Accept": 'application/json',
      },
    );
    if (isValidResponse(_response.statusCode)) {
      //Decode incoming json.
      return jsonDecode(_response.body);
    } else {
      validateResponse(_response);
    }
  }
}
