import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revival/core/routes.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/features/login/data/repo/creds_repo_imp.dart';
import 'package:revival/features/login/data/repo/login_repo_imp.dart';
import 'package:revival/features/login/domain/usecase/creds_usecase.dart';
import 'package:revival/features/login/domain/usecase/login_usecase.dart';
import 'package:revival/features/login/presentation/cubit/login_cubit.dart';
import 'dart:ui' as ui;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: [const Locale('en', 'US'), const Locale('ar', 'EG')],
      fallbackLocale: const Locale('en', 'US'),
      path: 'assets/translations',
      child: const RevivalApp(),
    ),
  );
}

class RevivalApp extends StatelessWidget {
  const RevivalApp({super.key});

  @override
  Widget build(BuildContext context) {
    final credentialsRepo = CredsRepoImp();
    final loginRepo = LoginRepoImp();
    final credentialsUseCase = CredentialsUseCase(credentialsRepo);
    final loginUsecase = LoginUseCase(loginRepo, credentialsRepo);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => LoginCubit(
                loginUsecase: loginUsecase,
                credentialsUseCase: credentialsUseCase,
              ),
        ),
      ],
      child: MaterialApp.router(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        builder: (context, child) {
          return Directionality(
            textDirection:
                context.locale.languageCode == 'ar'
                    ? ui.TextDirection.rtl
                    : ui.TextDirection.ltr,
            child: child!,
          );
        },
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        title: 'Revival',
      ),
    );
  }
}
