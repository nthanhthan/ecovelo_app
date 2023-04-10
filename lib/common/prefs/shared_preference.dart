import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  ///
  /// Instantiation of the SharedPreferences library
  ///
  static  SharedPreferences? _prefs;
  static Future<SharedPreferences?> load() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs;
  }

  // ----------------------------------------------------------
  /// Method that read/saves bool
  /// ----------------------------------------------------------
  static Future<bool> saveBool(String key, bool value) async {
    await load();
    return _prefs!.setBool(key, value);
  }

  static bool getBool(String key, {bool defaultValue = false}) {
    return _prefs!.getBool(key) ?? defaultValue;
  }

  // ----------------------------------------------------------
  /// Method that read/saves int
  /// ----------------------------------------------------------
  static Future<bool> saveInt(String key, int value) async {
    await load();
    return _prefs!.setInt(key, value);
  }

  static int getInt(String key, {int defaultValue = 0}) {
    return _prefs?.getInt(key) ?? defaultValue;
  }

  // ----------------------------------------------------------
  /// Method that read/saves double
  /// ----------------------------------------------------------
  static Future<bool> saveDouble(String key, double value) async {
    await load();
    return _prefs!.setDouble(key, value);
  }

  static double getDouble(String key, {double defaultValue = 0}) {
    return _prefs?.getDouble(key) ?? defaultValue;
  }

  // ----------------------------------------------------------
  /// Method that read/saves string
  /// ----------------------------------------------------------
  static Future<bool> saveString(String key, String value) async {
    await load();
    return _prefs!.setString(key, value);
  }

  static String getString(String key, {String defaultValue = ""}) {
    return _prefs?.getString(key) ?? defaultValue;
  }

  // ----------------------------------------------------------
  /// Method that read/saves list string
  /// ----------------------------------------------------------
  static Future<bool> saveListString(String key, List<String> value) async {
    await load();
    return _prefs!.setStringList(key, value);
  }

  static List<String> getListString(String key) {
    return _prefs?.getStringList(key) ?? [];
  }

  // ----------------------------------------------------------
  /// Method that clear all
  /// ----------------------------------------------------------
  static Future<bool> clear() async {
    await load();
    return _prefs!.clear();
  }

  static Future<bool> removeKey(String key) async {
    await load();
    return _prefs!.remove(key);
  }
}
