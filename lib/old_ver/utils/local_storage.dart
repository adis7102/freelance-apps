import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<String> get(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.get(key);
    return value;
  }

  static Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static Future<void> set(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
}