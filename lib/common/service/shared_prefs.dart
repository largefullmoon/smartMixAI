import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService extends GetxService {
  SharedPreferences? _prefs;

  Future<SharedPrefsService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  SharedPreferences get prefs {
    if (_prefs == null) {
      throw StateError('SharedPrefsService not initialized. Call init() first.');
    }
    return _prefs!;
  }

  Future<void> setString(String key, String value) async {
    await prefs.setString(key, value);
  }

  String? getString(String key) {
    return prefs.getString(key);
  }

  Future<void> setInt(String key, int value) async {
    await prefs.setInt(key, value);
  }

  int? getInt(String key) {
    return prefs.getInt(key);
  }

  Future<void> setBool(String key, bool value) async {
    await prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    return prefs.getBool(key);
  }

  Future<void> remove(String key) async {
    await prefs.remove(key);
  }

  Future<void> clear() async {
    await prefs.clear();
  }

  Future<void> setCustomObject<T>(String key, T value, T Function(Map<String, dynamic>) fromJson, Map<String, dynamic> Function(T) toJson) async {
    String jsonString = jsonEncode(toJson(value));
    await prefs.setString(key, jsonString);
  }

  T? getCustomObject<T>(String key, T Function(Map<String, dynamic>) fromJson) {
    String? jsonString = prefs.getString(key);
    if (jsonString == null) return null;
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return fromJson(jsonMap);
  }
}