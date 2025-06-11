import 'package:dartz/dartz.dart';
import 'package:revival/core/failures/failures.dart';
import 'package:revival/features/login/domain/entities/auth_token.dart';
import 'package:revival/features/login/domain/entities/user_creds.dart';

abstract class LoginRepo {
  Future<Either<Failures, AuthToken>> login({
    required UserCredentials userCredentials,
    required bool isRememberMe,
  });
  Future<Either<Failures, String>> forgotPassword({
    required String dbname,
    required String username,
  });
}
