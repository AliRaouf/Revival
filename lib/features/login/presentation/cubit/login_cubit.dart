import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:revival/core/failures/failures.dart';
import 'package:revival/features/login/domain/entities/auth_token.dart';
import 'package:revival/features/login/domain/entities/user_creds.dart';
import 'package:revival/features/login/domain/usecase/creds_usecase.dart';
import 'package:revival/features/login/domain/usecase/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginCubitState> {
  final LoginUseCase _loginUsecase;
  final CredentialsUseCase _credentialsUseCase;
  LoginCubit({
    required LoginUseCase loginUsecase,
    required CredentialsUseCase credentialsUseCase,
  }) : _loginUsecase = loginUsecase,
       _credentialsUseCase = credentialsUseCase,
       super(LoginCubitInitial());
  Future<void> loadSavedCredentials() async {
    try {
      final (rememberMe, userCredentials) =
          await _credentialsUseCase.executeLoadCredentials();
      emit(
        CredentialsSuccess(
          rememberMe: rememberMe,
          userCredentials: userCredentials,
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<Either<Failures, AuthToken>> login({
    // Changed return type to return the result
    required UserCredentials userCredentials,
    required bool rememberMe,
  }) async {
    emit(LoginLoading());

    try {
      final result = await _loginUsecase.executeLogin(
        userCredentials: userCredentials,
        isRememberMe: rememberMe,
      );

      result.fold(
        (failure) => emit(LoginError(errorMessage: failure.errMessage)),
        (authToken) => emit(LoginSuccess(authToken: authToken)),
      );

      return result;
    } catch (e) {
      emit(LoginError(errorMessage: e.toString()));
      return Left(ServerFailure(e.toString()));
    }
  }
}
