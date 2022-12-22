import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static final _manager = SharedPreferencesManager._internal();

  factory SharedPreferencesManager() => _manager;

  SharedPreferencesManager._internal();

  SharedPreferences? _prefs;

  Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future remove(String key) async {
    await _prefs?.remove(key);
  }
///gán dữ liệu vào
  Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }
///lấy dữ liệu lên
  Future<String?> getString(String key) async {
    return  _prefs?.getString(key);
  }
}

const phoneKey = 'phoneKey';


final sharedPrefs = SharedPreferencesManager();
