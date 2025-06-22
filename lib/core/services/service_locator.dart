import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:revival/core/services/api_service.dart';
import 'package:revival/features/login/data/repo/creds_repo_imp.dart';
import 'package:revival/features/login/data/repo/login_repo_imp.dart';
import 'package:revival/features/login/domain/repo/creds_repo.dart';
import 'package:revival/features/login/domain/repo/login_repo.dart';
import 'package:revival/features/login/domain/usecase/creds_usecase.dart';
import 'package:revival/features/login/domain/usecase/login_usecase.dart';
import 'package:revival/features/login/presentation/cubit/login_cubit.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  await dotenv.load(fileName: ".env");
  final dio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['base_url'] ?? 'https://api.example.com',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );
  getIt.registerLazySingleton<Dio>(() => dio);
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<Dio>()));
  // Repos
  getIt.registerLazySingleton<CredentialsRepo>(() => CredsRepoImp());
  getIt.registerLazySingleton<LoginRepo>(
    () => LoginRepoImp(getIt<ApiService>()),
  );

  // UseCases
  getIt.registerLazySingleton(
    () => CredentialsUseCase(getIt<CredentialsRepo>()),
  );
  getIt.registerLazySingleton(
    () => LoginUseCase(getIt<LoginRepo>(), getIt<CredentialsRepo>()),
  );

  // Cubits
  getIt.registerFactory(
    () => LoginCubit(loginUsecase: getIt()),
  );
}
