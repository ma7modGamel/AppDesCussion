import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  var value;
  Future<String> getValue(String key) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      value = preferences.get(key);
      print(value);
      return value;
    } catch (e) {
      return e;
    }
  }

  Future<bool> getBool(String key) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      value = preferences.getBool(key);
      return value;
    } catch (e) {
      return e;
    }
  }

  Future setBool(String key, bool value) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final result = preferences.setBool(key, value);
      return result;
    } catch (e) {
      return e;
    }
  }

  Future setValue(String key, String value) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final result = preferences.setString(key, value);
      print(value);
      return result;
    } catch (e) {
      return e;
    }
  }

  Future delete(String key) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      final result = await pref.remove(key);
      print(result);
      return result;
    } catch (e) {
      return e;
    }
  }
}
