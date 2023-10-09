import 'package:shared_preferences/shared_preferences.dart';

final _pref = SharedPreferences.getInstance();

class SharedService {
  static Future<void> saveDouble(String key, double value) async {
    SharedPreferences pref = await _pref;

    await pref.setDouble(key, value);
  }

  static Future<double?> getDouble(String key) async {
    if (!await hasKey(key)) {
      return null;
    }

    SharedPreferences pref = await _pref;

    return pref.getDouble(key);
  }

  static Future<void> saveBool(String key, bool value) async {
    SharedPreferences pref = await _pref;

    await pref.setBool(key, value);
  }

  static Future<bool?> getBool(String key) async {
    if (!await hasKey(key)) {
      return null;
    }

    SharedPreferences pref = await _pref;

    return pref.getBool(key);
  }

  static Future<void> saveInt(String key, int value) async {
    SharedPreferences pref = await _pref;

    await pref.setInt(key, value);
  }

  static Future<int?> getInt(String key) async {
    if (!await hasKey(key)) {
      return null;
    }

    SharedPreferences pref = await _pref;

    return pref.getInt(key);
  }

  static Future<void> saveString(String key, String value) async {
    SharedPreferences pref = await _pref;

    await pref.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    if (!await hasKey(key)) {
      return null;
    }

    SharedPreferences pref = await _pref;

    return pref.getString(key);
  }

  static Future<bool> hasKey(String key) async {
    SharedPreferences pref = await _pref;

    return pref.containsKey(key);
  }

  static Future<void> remove(String key) async {
    SharedPreferences pref = await _pref;

    await pref.remove(key);
  }
}
