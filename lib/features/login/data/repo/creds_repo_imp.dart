import 'package:revival/features/login/domain/entities/user_creds.dart';
import 'package:revival/features/login/domain/repo/creds_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Implementation of the CredentialsRepo using SharedPreferences.
class CredsRepoImp implements CredentialsRepo {
  // Keys for SharedPreferences
  static const String _rememberMeKey = 'rememberMe';
  static const String _databaseNameKey = 'databaseName';
  static const String _usernameKey = 'username';
  // NOTE: Storing passwords directly in SharedPreferences is generally discouraged
  // due to security risks. Consider using a more secure storage mechanism
  // like flutter_secure_storage for sensitive information.
  static const String _passwordKey = 'password';

  @override
  Future<void> saveCredentials(UserCredentials credentials) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_databaseNameKey, credentials.dbName);
    await prefs.setString(_usernameKey, credentials.username);
    await prefs.setString(_passwordKey, credentials.password);
  }

  @override
  Future<UserCredentials?> loadCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final dbname = prefs.getString(_databaseNameKey);
    final username = prefs.getString(_usernameKey);
    final password = prefs.getString(_passwordKey);

    if (dbname != null && username != null && password != null) {
      return UserCredentials(
        dbName: dbname,
        username: username,
        password: password,
      );
    }
    return null; // Return null if any credential is not found
  }

  @override
  Future<void> clearCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_databaseNameKey);
    await prefs.remove(_usernameKey);
    await prefs.remove(_passwordKey);
  }

  @override
  Future<void> setRememberMePreference(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_rememberMeKey, enabled);
  }

  @override
  Future<bool> getRememberMePreference() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_rememberMeKey) ?? false; // Default to false if not set
  }
}
