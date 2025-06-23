import 'package:revival/features/login/domain/entities/user_creds.dart';
import 'package:revival/features/login/domain/repo/creds_repo.dart';

class CredsRepoImp implements CredentialsRepo {
  static const String _rememberMeKey = 'rememberMe';
  static const String _databaseNameKey = 'databaseName';
  static const String _usernameKey = 'username';

  static const String _passwordKey = 'password';

  @override
  Future<void> clearCredentials() {
    // TODO: implement clearCredentials
    throw UnimplementedError();
  }

  @override
  Future<bool> getRememberMePreference() {
    // TODO: implement getRememberMePreference
    throw UnimplementedError();
  }

  @override
  Future<UserCredentials?> loadCredentials() {
    // TODO: implement loadCredentials
    throw UnimplementedError();
  }

  @override
  Future<void> setRememberMePreference(bool enabled) {
    // TODO: implement setRememberMePreference
    throw UnimplementedError();
  }
}
