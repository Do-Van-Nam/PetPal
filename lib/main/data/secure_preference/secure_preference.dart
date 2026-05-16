import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureKey {
  static const String keyAccessToken = 'KEY_ACCESS_TOKEN';
  static const String keyRefreshToken = 'KEY_REFRESH_TOKEN';
  static const String keyLoginToken = 'KEY_LOGIN_TOKEN';
  static const String keyPhoneNumber = 'KEY_PHONE_NUMBER';
  static const String keyOtpCode = 'KEY_OTP_CODE';
  static const String keyUserId = 'KEY_USER_ID';
}

class SecurePreferenceUtil {
  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );

  static Future<void> setString(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  static Future<String> getString(
    String key, {
    String defaultValue = '',
  }) async {
    return await _storage.read(key: key) ?? defaultValue;
  }

  static Future<void> setBool(String key, bool value) async {
    await setString(key, value.toString());
  }

  static Future<bool> getBool(
    String key, {
    bool defaultValue = false,
  }) async {
    final value = await _storage.read(key: key);
    if (value == null) return defaultValue;
    return value.toLowerCase() == 'true';
  }

  static Future<void> setInt(String key, int value) async {
    await setString(key, value.toString());
  }

  static Future<int> getInt(
    String key, {
    int defaultValue = 0,
  }) async {
    final value = await _storage.read(key: key);
    if (value == null) return defaultValue;
    return int.tryParse(value) ?? defaultValue;
  }

  static Future<void> setDouble(String key, double value) async {
    await setString(key, value.toString());
  }

  static Future<double> getDouble(
    String key, {
    double defaultValue = 0.0,
  }) async {
    final value = await _storage.read(key: key);
    if (value == null) return defaultValue;
    return double.tryParse(value) ?? defaultValue;
  }

  static Future<bool> containsKey(String key) async {
    return _storage.containsKey(key: key);
  }

  static Future<Map<String, String>> readAll() async {
    return _storage.readAll();
  }

  static Future<void> remove(String key) async {
    await _storage.delete(key: key);
  }

  static Future<void> clear() async {
    await _storage.deleteAll();
  }

  static Future<void> saveAccessToken(String token) async {
    await setString(SecureKey.keyAccessToken, token);
  }

  static Future<String> getAccessToken() async {
    return getString(SecureKey.keyAccessToken);
  }

  static Future<void> saveRefreshToken(String token) async {
    await setString(SecureKey.keyRefreshToken, token);
  }

  static Future<String> getRefreshToken() async {
    return getString(SecureKey.keyRefreshToken);
  }

  static Future<void> saveLoginToken(String token) async {
    await setString(SecureKey.keyLoginToken, token);
  }

  static Future<String> getLoginToken() async {
    return getString(SecureKey.keyLoginToken);
  }

  static Future<void> savePhoneNumber(String phoneNumber) async {
    await setString(SecureKey.keyPhoneNumber, phoneNumber);
  }

  static Future<String> getPhoneNumber() async {
    return getString(SecureKey.keyPhoneNumber);
  }

  static Future<void> saveOtpCode(String otpCode) async {
    await setString(SecureKey.keyOtpCode, otpCode);
  }

  static Future<String> getOtpCode() async {
    return getString(SecureKey.keyOtpCode);
  }

  static Future<void> saveUserId(String userId) async {
    await setString(SecureKey.keyUserId, userId);
  }

  static Future<String> getUserId() async {
    return getString(SecureKey.keyUserId);
  }

  static Future<void> clearAuth() async {
    await Future.wait([
      remove(SecureKey.keyAccessToken),
      remove(SecureKey.keyRefreshToken),
      remove(SecureKey.keyLoginToken),
      remove(SecureKey.keyPhoneNumber),
      remove(SecureKey.keyOtpCode),
      remove(SecureKey.keyUserId),
    ]);
  }
}
