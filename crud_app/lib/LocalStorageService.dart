import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _keyUsername = 'username';
  static const String _keyPassword = 'password';

  Future<void> saveCredentials(String username, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_keyUsername, username);
    prefs.setString(_keyPassword, password);
  }

  Future<Map<String, String?>> getCredentials() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? username = prefs.getString(_keyUsername);
    final String? password = prefs.getString(_keyPassword);

    return {'username': username, 'password': password};
  }
}