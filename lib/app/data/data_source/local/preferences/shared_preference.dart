import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  // The instance of SecureStorageService
  static final SecureStorageService _instance = SecureStorageService._internal();

  // The flutter secure storage instance
  late final FlutterSecureStorage _secureStorage;

  // Factory constructor to return the same instance every time it's called
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


  // Method to write data
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

  // Method to read data
  Future<T?> read<T>(String key) async {
    String? stringValue = await _secureStorage.read(key: key);

    if (stringValue == null) {
      return null;
    }

    try {
      // Handle conversion based on the generic type
      if (T == String) {
        return stringValue as T;
      } else if (T == int) {
        return int.tryParse(stringValue) as T?;
      } else if (T == double) {
        return double.tryParse(stringValue) as T?;
      } else if (T == bool) {
        return (stringValue.toLowerCase() == 'true') as T;
      } else {
        // Attempt to decode JSON for complex types
        return jsonDecode(stringValue) as T;
      }
    } catch (e) {
      // Log the error or handle it as appropriate in your app
      debugPrint('Error decoding value for key $key: $e');
      return null;
    }
  }


  // Method to delete data
  Future<void> delete(String key) async {
    await _secureStorage.delete(key: key);
  }

  // Method to check if a key exists
  Future<bool> containsKey(String key) async {
    return await _secureStorage.containsKey(key: key);
  }

  // Method to delete all data
  Future<void> deleteAll() async {
    await _secureStorage.deleteAll();
  }

  // Method to get Android options
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );

  // Method to get iOS options
  IOSOptions _getIOSOptions() => const IOSOptions(
    accessibility: KeychainAccessibility.first_unlock,
  );
}
