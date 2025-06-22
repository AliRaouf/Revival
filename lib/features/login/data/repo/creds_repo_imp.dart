import 'package:revival/features/login/domain/entities/user_creds.dart';
import 'package:revival/features/login/domain/repo/creds_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CredsRepoImp implements CredentialsRepo {
  
  static const String _rememberMeKey = 'rememberMe';
  static const String _databaseNameKey = 'databaseName';
  static const String _usernameKey = 'username';

  static const String _passwordKey = 'password';

  @override
  Future<UserCredentials?> loadCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final dbname = prefs.getString(_databaseNameKey);
    final username = prefs.getString(_usernameKey);
    final password = prefs.getString(_passwordKey);

    if (dbname != null && username != null && password != null) {
      return UserCredentials(username: username, password: password);
    }
    return null;
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
    return prefs.getBool(_rememberMeKey) ?? false;
  }
}
