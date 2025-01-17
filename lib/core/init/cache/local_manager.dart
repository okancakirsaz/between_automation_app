import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocaleManager {
  static LocaleManager instance = LocaleManager();
  late SharedPreferences _instance;
  Future<void> getSharedPreferencesInstance() async {
    _instance = await SharedPreferences.getInstance();
  }

  Future<void> setJsonData(String key, dynamic value) async {
    await _instance.setString(key, jsonEncode(value));
  }

  Future<void> setNullableJsonData(
      String key, Map<String, dynamic>? value) async {
    if (value != null) {
      await _instance.setString(key, jsonEncode(value));
    }
  }

  getJsonData(String key) {
    return jsonDecode(_instance.getString(key)!);
  }

  getNullableJsonData(String key) {
    String? data = _instance.getString(key);
    return data != null ? jsonDecode(data) : null;
  }

  Future<void> setStringData(String key, String value) async {
    await _instance.setString(key, value);
  }

  Future<void> setNullableStringData(String key, String? value) async {
    if (value != null) {
      await _instance.setString(key, value);
    }
  }

  String? getNullableStringData(String key) {
    return _instance.getString(key);
  }

  Future<void> removeData(String key) async {
    await _instance.remove(key);
  }
}
