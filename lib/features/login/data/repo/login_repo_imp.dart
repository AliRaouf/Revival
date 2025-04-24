import 'package:dartz/dartz.dart';
import 'package:revival/core/failures/failures.dart'; // Assuming Failures class exists
import 'package:revival/features/login/domain/entities/auth_token.dart'; // Assuming AuthToken class exists
import 'package:revival/features/login/domain/entities/user_creds.dart';
import 'package:revival/features/login/domain/repo/login_repo.dart';

class LoginRepoImp implements LoginRepo {
  @override
  Future<Either<Failures, AuthToken>> login({
    required UserCredentials userCredentials,
    required bool isRememberMe,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    if (userCredentials.username == 'test' &&
        userCredentials.password == 'test') {
      return Right(AuthToken(token: 'dummy_auth_token_12345'));
    } else {
      // Simulate a failed login
      print('Login failed for user: ${userCredentials.username}');
      // Return a Failure on failure
      return Left(ServerFailure('Invalid credentials'));
    }
  }

  @override
  Future<Either<Failures, String>> forgotPassword({
    required String dbname,
    required String username,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    print('Forgot password requested for user: $username in database: $dbname');
    return Right('Password reset instructions sent to your email.');
  }
}
