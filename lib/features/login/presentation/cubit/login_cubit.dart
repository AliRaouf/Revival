import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:meta/meta.dart';
import 'package:revival/core/failures/failures.dart';
import 'package:revival/core/services/service_locator.dart';
import 'package:revival/features/login/data/model/user/user.dart';
import 'package:revival/features/login/domain/entities/user_creds.dart';
import 'package:revival/features/login/domain/usecase/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginCubitState> {
  final LoginUseCase _loginUsecase;
  LoginCubit({required LoginUseCase loginUsecase})
    : _loginUsecase = loginUsecase,
      super(LoginCubitInitial());

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final LocalAuthentication _localAuth = LocalAuthentication();

  Future<void> storeCredentialsForBiometricLogin(UserCredentials creds) async {
    await _secureStorage.write(key: 'username', value: creds.username);
    await _secureStorage.write(key: 'password', value: creds.password);
    await _secureStorage.write(key: 'companyDB', value: creds.companyDB);
  }

  Future<void> clearStoredCredentials() async {
    await _secureStorage.delete(key: 'username');
    await _secureStorage.delete(key: 'password');
    await _secureStorage.delete(key: 'companyDB');
  }

  Future<void> attemptBiometricLogin() async {
    try {
      final canCheckBiometrics = await _localAuth.canCheckBiometrics;
      final isDeviceSupported = await _localAuth.isDeviceSupported();

      if (!canCheckBiometrics || !isDeviceSupported) {
        emit(LoginError(errorMessage: 'biometric_not_supported'.tr()));
        return;
      }

      final didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'biometric_prompt'.tr(),
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      if (didAuthenticate) {
        final username = await _secureStorage.read(key: 'username');
        final password = await _secureStorage.read(key: 'password');
        final companyDB = await _secureStorage.read(key: "companyDB");

        if (username != null && password != null && companyDB != null) {
          final creds = UserCredentials(
            username: username,
            password: password,
            companyDB: companyDB,
          );
          await login(userCredentials: creds, rememberMe: true);
        } else {
          emit(LoginError(errorMessage: 'no_stored_credentials'.tr()));
        }
      } else {
        emit(LoginError(errorMessage: 'biometric_auth_failed'.tr()));
      }
    } catch (e) {
      emit(LoginError(errorMessage: e.toString()));
    }
  }

  // Future<void> loadSavedCredentials() async {
  //   try {
  //     final (rememberMe, userCredentials) =
  //         await _credentialsUseCase.executeLoadCredentials();
  //     emit(
  //       CredentialsSuccess(
  //         rememberMe: rememberMe,
  //         userCredentials: userCredentials,
  //       ),
  //     );
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future<Either<Failures, User>> login({
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
        (user) {
          emit(LoginSuccess(user: user));
          storeCredentialsForBiometricLogin(userCredentials);
          final dio = getIt<Dio>();
          dio.options.headers['Authorization'] = 'Bearer ${user.data!.token}';
        },
      );

      return result;
    } catch (e) {
      emit(LoginError(errorMessage: e.toString()));
      return Left(ServerFailure(e.toString()));
    }
  }
}
