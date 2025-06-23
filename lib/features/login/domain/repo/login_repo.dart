import 'package:dartz/dartz.dart';
import 'package:revival/core/failures/failures.dart';
import 'package:revival/features/login/data/model/user/user.dart';
import 'package:revival/features/login/domain/entities/user_creds.dart';

abstract class LoginRepo {
  Future<Either<Failures, User>> login({
    required UserCredentials userCredentials,
  });
}
