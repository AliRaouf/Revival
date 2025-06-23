import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:revival/core/failures/failures.dart';
import 'package:revival/core/services/api_service.dart';
import 'package:revival/features/login/data/model/user/user.dart';
import 'package:revival/features/login/domain/entities/user_creds.dart';
import 'package:revival/features/login/domain/repo/login_repo.dart';

class LoginRepoImp implements LoginRepo {
  final ApiService apiService;
  LoginRepoImp(this.apiService);
  @override
  Future<Either<Failures, User>> login({
    required UserCredentials userCredentials,
  }) async {
    try {
      final user = await apiService.post(
        '/vansales/login',
        data: userCredentials.toJson(),
      );
      return right(User.fromJson(user));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure(ServerFailure.fromDioError(e).errMessage));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
