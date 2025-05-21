import 'package:dartz/dartz.dart';
import 'package:revival/core/failures/failures.dart';
import 'package:revival/features/login/domain/entities/auth_token.dart';
import 'package:revival/features/login/domain/entities/user_creds.dart';
import 'package:revival/features/login/domain/repo/creds_repo.dart';
import 'package:revival/features/login/domain/repo/login_repo.dart';

class LoginUseCase {
  final LoginRepo _loginRepository;
  final CredentialsRepo _credentialsRepository;
  LoginUseCase(this._loginRepository, this._credentialsRepository);
  Future<Either<Failures, AuthToken>>executeLogin({required UserCredentials userCredentials,required bool isRememberMe})async{
    final result = await _loginRepository.login(
      userCredentials: userCredentials,
      isRememberMe: isRememberMe,
    );
    await _credentialsRepository.setRememberMePreference(isRememberMe);
    return result;
  }
}
