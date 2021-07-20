import 'dart:developer';

import 'package:flutter/services.dart' show PlatformException;
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  PreferenceUtils._();
  static SharedPreferences? _preferences;
  static PreferenceUtils _instance = PreferenceUtils._();

  //Retuns an instance of the class to interface with.
  static PreferenceUtils? get instance {
    if (_preferences == null) return null;
    return _instance;
  }

  ///* init the class in `main` function
  static Future<void> init() async {
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
      log("Shared Preferences has been initiated");
    }
  }

  /// `T` is the  `runTimeType` data which you are trying to save (`bool` - `String` - `double`)
  Future<bool> saveValueWithKey<T>(String key, T value, {bool hideDebugPrint = false}) async {
    if (!hideDebugPrint) log("SharedPreferences: [Saving data] -> key: $key, value: $value");
    assert(_preferences != null);
    if (value is String) {
      return await _preferences!.setString(key, value);
    } else if (value is bool) {
      return await _preferences!.setBool(key, value);
    } else if (value is double) {
      return await _preferences!.setDouble(key, value);
    } else if (value is int) {
      return await _preferences!.setInt(key, value);
    } else if (value is List<String>) {
      log("WARNING: You are trying to save a [value] of type [List<String>]");
      await _preferences!.setStringList(key, value);
    } else {
      throw "Not a supported type";
    }
    return false;
  }

  ///Get a saved value using given `Key`.
  ///
  ///if value does not exist returns `null`.
  E? getValueWithKey<E>(
    String key, {
    bool bypassValueChecking = true,
    bool hideDebugPrint = false,
  }) {
    assert(_preferences != null);
    var value = _preferences!.get(key);
    if (value == null && !bypassValueChecking) {
      throw PlatformException(
          code: "SHARED_PREFERENCES_VALUE_CAN'T_BE_NULL",
          message: "you have ordered a value which doesn't exist in Shared Preferences",
          details: "make sure you have saved the value in advance in order to get it back");
    }
    if (!hideDebugPrint) log("SharedPreferences: [Reading data] -> key: $key, value: $value");
    return value as E?;
  }

  ///Remove saved value with `Key` form local DB.
  Future<bool> removeValueWithKey(String key) async {
    assert(_preferences != null);
    var value = _preferences?.get(key);
    if (value == null) return true;
    log("SharedPreferences: [Removing data] -> key: $key, value: $value");
    return await _preferences!.remove(key);
  }

  ///Remove saved values with `Keys` form local DB.
  Future<void> removeMultipleValuesWithKeys(List<String> keys) async {
    assert(_preferences != null);
    var value;
    for (String key in keys) {
      value = _preferences!.get(key);
      if (value == null) {
        log("SharedPreferences: [Removing data] -> key: $key, value: {ERROR 'null' value}");
        log("Skipping...");
      } else {
        await _preferences!.remove(key);
        log("SharedPreferences: [Removing data] -> key: $key, value: $value");
      }
    }
    return;
  }

  ///Clear all app saved preferences.
  Future<bool> clearAll() async {
    assert(_preferences != null);
    return await _preferences!.clear();
  }
}
