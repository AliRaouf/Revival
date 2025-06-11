import 'package:revival/features/login/domain/entities/user_creds.dart';

abstract class CredentialsRepo {
  Future<UserCredentials?> loadCredentials();
  Future<void> clearCredentials();
  Future<void> setRememberMePreference(bool enabled);
  Future<bool> getRememberMePreference();
}
