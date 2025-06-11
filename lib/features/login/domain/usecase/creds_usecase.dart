import 'package:revival/features/login/domain/entities/user_creds.dart';
import 'package:revival/features/login/domain/repo/creds_repo.dart';

class CredentialsUseCase {
  final CredentialsRepo _credentialsRepository;

  CredentialsUseCase(this._credentialsRepository);
  Future<(bool, UserCredentials)> executeLoadCredentials() async {
    final bool rememberMe =
        await _credentialsRepository.getRememberMePreference();
    UserCredentials? userCredentials;
    if (rememberMe) {
      userCredentials = await _credentialsRepository.loadCredentials();
    }
    return (rememberMe, userCredentials!);
  }
}
