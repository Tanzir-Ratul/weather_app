import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static final SecureStorageService _instance = SecureStorageService._internal();

  late final FlutterSecureStorage _secureStorage;

  factory SecureStorageService() {
    return _instance;
  }

  // Private constructor for internal usage
  SecureStorageService._internal() {
    _secureStorage = FlutterSecureStorage(
      aOptions: _getAndroidOptions(),
      iOptions: _getIOSOptions(),
    );
  }


  Future<void> write(String key, dynamic value) async {
    String stringValue;

    if (value is String) {
      stringValue = value;
    } else if (value is int || value is double || value is bool) {
      stringValue = value.toString();
    } else {
      // For more complex types, convert to JSON string
      stringValue = jsonEncode(value);
    }

    await _secureStorage.write(key: key, value: stringValue);
  }

  Future<T?> read<T>(String key) async {
    String? stringValue = await _secureStorage.read(key: key);

    if (stringValue == null) {
      return null;
    }

    try {
      if (T == String) {
        return stringValue as T;
      } else if (T == int) {
        return int.tryParse(stringValue) as T?;
      } else if (T == double) {
        return double.tryParse(stringValue) as T?;
      } else if (T == bool) {
        return (stringValue.toLowerCase() == 'true') as T;
      } else {
        return jsonDecode(stringValue) as T;
      }
    } catch (e) {
      debugPrint('Error decoding value for key $key: $e');
      return null;
    }
  }


  Future<void> delete(String key) async {
    await _secureStorage.delete(key: key);
  }

  Future<bool> containsKey(String key) async {
    return await _secureStorage.containsKey(key: key);
  }

  Future<void> deleteAll() async {
    await _secureStorage.deleteAll();
  }

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );

  IOSOptions _getIOSOptions() => const IOSOptions(
    accessibility: KeychainAccessibility.first_unlock,
  );
}
