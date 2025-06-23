import 'package:dartz/dartz.dart';
import 'package:revival/core/failures/failures.dart';
import 'package:revival/features/login/data/model/user/user.dart';
import 'package:revival/features/login/domain/entities/user_creds.dart';
import 'package:revival/features/login/domain/repo/login_repo.dart';

class LoginUseCase {
  final LoginRepo _loginRepository;
  LoginUseCase(this._loginRepository);
  Future<Either<Failures, User>> executeLogin({
    required UserCredentials userCredentials,
    required bool isRememberMe,
  }) async {
    final result = await _loginRepository.login(
      userCredentials: userCredentials,
    );
    return result;
  }
}
