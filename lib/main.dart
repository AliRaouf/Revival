import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/features/login/data/repo/creds_repo_imp.dart';
import 'package:revival/features/login/data/repo/login_repo_imp.dart';
import 'package:revival/features/login/domain/usecase/creds_usecase.dart';
import 'package:revival/features/login/domain/usecase/login_usecase.dart';
import 'package:revival/features/login/presentation/cubit/login_cubit.dart';
import 'features/login/presentation/views/login_page.dart';

void main() {
  runApp(const RevivalApp());
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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        title: 'Revival',
        home: const Scaffold(body: LoginPage()),
      ),
    );
  }
}
