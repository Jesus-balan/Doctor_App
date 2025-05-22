import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static final HiveService _instance = HiveService._internal();

  factory HiveService() => _instance;

  HiveService._internal();

  static const String _authBox = 'authBox';
  static const String _tokenKey = 'token';

  // Open the auth box
  Future<Box> _getAuthBox() async {
    if (Hive.isBoxOpen(_authBox)) {
      return Hive.box(_authBox);
    } else {
      return await Hive.openBox(_authBox);
    }
  }

  /// Save token
  Future<void> saveToken(String token) async {
    final box = await _getAuthBox();
    await box.put(_tokenKey, token);
  }

  /// Get token
  Future<String?> getToken() async {
    final box = await _getAuthBox();
    final token = box.get(_tokenKey);
    // print(token);
    return token;
  }

  /// Delete token
  Future<void> deleteToken() async {
    final box = await _getAuthBox();
    await box.delete(_tokenKey);
  }

  /// Check if token exists
  Future<bool> isLoggedIn() async {
    final box = await _getAuthBox();
    return box.containsKey(_tokenKey);
  }

  /// Clear all auth data (useful on logout)
  Future<void> clearAuthData() async {
    final box = await _getAuthBox();
    await box.clear();
  }

  Future<void> saveRefreshToken(String token) async {
  final box = await Hive.openBox('auth');
  await box.put('refreshToken', token);
}

Future<String?> getRefreshToken() async {
  final box = await Hive.openBox('auth');
  return box.get('refreshToken');
}

Future<void> deleteRefreshToken() async {
  final box = await Hive.openBox('auth');
  await box.delete('refreshToken');
}

Future<void> logout() async {
  await deleteToken();
  await deleteRefreshToken();
  await clearAuthData(); // optional: clear everything in authBox
}
}


// Example usage
// void main() async {
//   await HiveService.init(); // Initialize HiveService
//   await HiveService.saveToken('your_token_here'); // Save token
//   String? token = HiveService.getToken(); // Retrieve token
//   print(token); // Output: your_token_here
//   await HiveService.saveThemeMode(true); // Save theme mode
//   bool isDarkMode = HiveService.getThemeMode(); // Retrieve theme mode
//   print(isDarkMode); // Output: true
//   await HiveService.clear(); // Clear all data
//   token = HiveService.getToken(); // Retrieve token after clearing
//   print(token); // Output: null
// }

// Save token
// await HiveService.saveToken("abc123");

// Get token
// String? token = HiveService.getToken();

// Save theme mode
// await HiveService.saveThemeMode(true);

// Get theme mode
// bool isDark = HiveService.getThemeMode();

