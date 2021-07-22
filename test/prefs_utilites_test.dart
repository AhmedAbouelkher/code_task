import 'package:code_task/Helpers/PreferencesUtils/preferences_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'error_matchers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group("PreferenceUtils", () {
    test("Initializing", () async {
      final preferences = MockSharedPrefrences(<String, Object>{});
      await PreferenceUtils.initWithMock(preferences);
      final instance = PreferenceUtils.instance;
      expect(instance, isNotNull);
      expect(instance!.initilized, isTrue);
    });

    const Map<String, Object> kTestValues = <String, Object>{
      'flutter.String': 'hello world',
      'flutter.bool': true,
      'flutter.int': 42,
      'flutter.double': 3.14159,
      'flutter.List': <String>['foo', 'bar'],
      'flutter.map': <String, String>{'foo': 'bar'},
    };

    const Map<String, Object> kTestValues2 = <String, Object>{
      'flutter.String': 'goodbye world',
      'flutter.bool': false,
      'flutter.int': 1337,
      'flutter.double': 2.71828,
      'flutter.List': <String>['baz', 'quox'],
    };

    late PreferenceUtils prefs;

    setUp(() async {
      final preferences = MockSharedPrefrences(kTestValues2);
      await PreferenceUtils.initWithMock(preferences);
      prefs = PreferenceUtils.instance!;
    });

    test("Reading", () {
      expect(prefs.getValueWithKey("map"), isNull);
      expect(prefs.getValueWithKey("string"), kTestValues2["flutter.String"]);
      expect(prefs.getValueWithKey("int"), kTestValues2["flutter.int"]);
      expect(prefs.getValueWithKey("double"), kTestValues2["flutter.double"]);
      expect(prefs.getValueWithKey("bool"), kTestValues2["flutter.bool"]);
    });

    test("Writing", () {
      expect(prefs.saveValueWithKey("map", kTestValues["flutter.map"]), isNotSupportedTypeToSaveException);
      expect(prefs.saveValueWithKey("string", kTestValues["flutter.String"]), completion(isTrue));
      expect(prefs.saveValueWithKey("int", kTestValues["flutter.int"]), completion(isTrue));
      expect(prefs.saveValueWithKey("double", kTestValues["flutter.double"]), completion(isTrue));
      expect(prefs.saveValueWithKey("bool", kTestValues["flutter.bool"]), completion(isTrue));
    });

    test("Removing value", () {
      expect(prefs.removeValueWithKey("map"), completion(isTrue));
      expect(prefs.removeValueWithKey("string"), completion(isTrue));
      expect(prefs.removeValueWithKey("int"), completion(isTrue));
      expect(prefs.removeValueWithKey("double"), completion(isTrue));
      expect(prefs.removeValueWithKey("bool"), completion(isTrue));
    });

    test("Clearing PreferenceUtils", () {
      expect(prefs.clearAll(), completion(isTrue));
      expect(prefs.isEmpty(), isTrue);
    });
  });

  group("Mocking", () {
    test("String Value Test", () async {
      final preferences = MockSharedPrefrences({
        "string_test": "this is a string",
      });
      await PreferenceUtils.initWithMock(preferences);
      final instance = PreferenceUtils.instance;
      expect(instance!.getValueWithKey("string_test"), "this is a string");
    });

    test("Removing multiple values with keys", () async {
      final preferences = MockSharedPrefrences({
        "test": "this is a string",
        "test2": 210.58,
        "test3": true,
      });
      await PreferenceUtils.initWithMock(preferences);
      final instance = PreferenceUtils.instance;

      await instance!.removeMultipleValuesWithKeys([
        "test",
        "test2",
      ]);

      expect(instance.isEmpty(), isFalse);
      expect(instance.getValueWithKey("test3"), equals(true));
      expect(instance.removeValueWithKey("test3"), completion(isTrue));
      expect(instance.isEmpty(), isTrue);
    });
  });
}

class MockSharedPrefrences extends Mock implements BaseSharedPreferences {
  late Map<String, Object> _hashMap;
  bool hasBeenInitilzed = false;

  MockSharedPrefrences(Map<String, Object> values) {
    _hashMap = values.map<String, Object>((String key, Object value) {
      String newKey = key.split(".").last.toLowerCase();
      return MapEntry<String, Object>(newKey, value);
    });
  }

  @override
  Future<bool> clear() {
    _hashMap.clear();
    return Future.value(true);
  }

  @override
  Object? get(String key) {
    return _hashMap[key];
  }

  @override
  Future<bool> remove(String key) {
    final value = _hashMap.remove(key);
    return Future.value(value != null);
  }

  @override
  Future<bool> setBool(String key, bool value) {
    _hashMap[key] = value;
    return Future.value(true);
  }

  @override
  Future<bool> setDouble(String key, double value) {
    _hashMap[key] = value;
    return Future.value(true);
  }

  @override
  Future<bool> setInt(String key, int value) {
    _hashMap[key] = value;
    return Future.value(true);
  }

  @override
  Future<bool> setString(String key, String value) {
    _hashMap[key] = value;
    return Future.value(true);
  }

  @override
  bool isEmpty() => _hashMap.isEmpty;
}
