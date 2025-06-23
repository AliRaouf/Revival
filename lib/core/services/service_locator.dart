import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:revival/core/services/api_service.dart';
import 'package:revival/features/login/data/repo/creds_repo_imp.dart';
import 'package:revival/features/login/data/repo/login_repo_imp.dart';
import 'package:revival/features/login/domain/entities/auth_token.dart';
import 'package:revival/features/login/domain/repo/creds_repo.dart';
import 'package:revival/features/login/domain/repo/login_repo.dart';
import 'package:revival/features/login/domain/usecase/creds_usecase.dart';
import 'package:revival/features/login/domain/usecase/login_usecase.dart';
import 'package:revival/features/login/presentation/cubit/login_cubit.dart';
import 'package:revival/features/order/data/repo/order_repo_imp.dart';
import 'package:revival/features/order/domain/repo/order_repo.dart';
import 'package:revival/features/order/domain/use_case/copy_order_invoice.dart';
import 'package:revival/features/order/domain/use_case/get_open_orders.dart';
import 'package:revival/features/order/domain/use_case/get_order_details.dart';
import 'package:revival/features/order/presentation/cubit/copy_order_invoice/copy_order_invoice_cubit.dart';
import 'package:revival/features/order/presentation/cubit/open_order/order_cubit.dart';
import 'package:revival/features/order/presentation/cubit/single_order/single_order_cubit.dart';

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

  // Register CompanyDBID
  getIt.registerLazySingleton<OrderQuery>(() => OrderQuery());

  // Repos
  getIt.registerLazySingleton<CredentialsRepo>(() => CredsRepoImp());
  getIt.registerLazySingleton<LoginRepo>(
    () => LoginRepoImp(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<OrderRepo>(
    () => OrderRepoImp(getIt<ApiService>()),
  );
  // UseCases
  getIt.registerLazySingleton(
    () => CredentialsUseCase(getIt<CredentialsRepo>()),
  );
  getIt.registerLazySingleton(() => LoginUseCase(getIt<LoginRepo>()));
  getIt.registerLazySingleton(() => GetOpenOrders(getIt<OrderRepo>()));
  getIt.registerLazySingleton(() => GetOrderDetails(getIt<OrderRepo>()));
  getIt.registerLazySingleton(() => CopyOrderInvoice(getIt<OrderRepo>()));

  // Cubits
  getIt.registerFactory(() => LoginCubit(loginUsecase: getIt()));
  getIt.registerFactory(
    () => OrderCubit(getOpenOrders: getIt<GetOpenOrders>()),
  );
  getIt.registerFactory(
    () => SingleOrderCubit(getOrderDetails: getIt<GetOrderDetails>()),
  );
  getIt.registerFactory(
    () => CopyOrderInvoiceCubit(
      copyOrderInvoiceUseCase: getIt<CopyOrderInvoice>(),
    ),
  );
}
