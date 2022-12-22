import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecureStorageManager {
  static final _manager = SecureStorageManager._internal();

  factory SecureStorageManager() => _manager;

  SecureStorageManager._internal();

  FlutterSecureStorage? _storage;

  Future init() async {
    _storage = FlutterSecureStorage();
  }

  Future remove(String key) async {
    await _storage?.delete(key: key);
  }
  ///gán dữ liệu vào
  Future<void> setString(String key, String value) async {
    await _storage?.write(key: key,value: value);
  }
  ///lấy dữ liệu lên
  Future<String?> getString(String key) async {
    return  _storage?.read(key: key);
  }
}

// const phoneKey = 'phoneKey';


final secureStorage = SecureStorageManager();