import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  SharedPreferences? preferences;

  Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  Future<void> setBool(String key, bool value) async {
    await preferences?.setBool(key, value);
  }

  bool getBool(String key, {bool defaultValue = false}) {
    return preferences?.getBool(key) ?? defaultValue;
  }

  Future<void> setString(String key, String value) async {
    await preferences?.setString(key, value);
  }

  String? getString(String key) {
    return preferences?.getString(key);
  }

  Future<void> setInt(String key, int value) async {
    await preferences?.setInt(key, value);
  }
}
