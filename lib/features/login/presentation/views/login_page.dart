import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:revival/core/services/service_locator.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/features/login/domain/entities/auth_token.dart';
import 'package:revival/features/login/presentation/views/widgets/input_column.dart';
import 'package:revival/features/login/presentation/views/widgets/login_button.dart';
import 'package:revival/features/login/presentation/views/widgets/quick_login.dart';
import 'package:revival/features/order/presentation/cubit/open_order/order_cubit.dart';
import 'package:revival/shared/utils.dart';
import 'package:revival/shared/logo_image.dart';
import 'package:revival/features/login/domain/entities/user_creds.dart';
import 'package:revival/features/login/presentation/cubit/login_cubit.dart';
import 'package:revival/features/login/presentation/views/widgets/language_switcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final bool _obscureText = true;
  final _databaseNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  late AnimationController _logoAnimationController;
  late Animation<double> _logoAnimation;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _logoAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();

    _logoAnimation = CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.easeInOut,
    );
  }

  void _login() async {
    if (!await InternetConnection().hasInternetAccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'No internet connection. Please check your network settings.'.tr(),
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
    }

    if (_formKey.currentState?.validate() ?? false) {
      final userCredentials = UserCredentials(
        username: _usernameController.text,
        password: _passwordController.text,
        companyDB: _databaseNameController.text,
      );

      context.read<LoginCubit>().login(
        userCredentials: userCredentials,
        rememberMe: _rememberMe,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final utilities = Utilities(context);

    final cardWidth =
        utilities.isTablet
            ? utilities.screenSize.width * 0.6
            : utilities.screenSize.width * 0.9;

    return Scaffold(
      body: Container(
        color: scaffoldBackgroundColor,
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: utilities.isTablet ? 24 : 16,
              vertical: utilities.isTablet ? 32 : 20,
            ),
            child: Form(
              key: _formKey,

              child: BlocConsumer<LoginCubit, LoginCubitState>(
                listener: (context, state) {
                  if (state is CredentialsSuccess) {
                    setState(() {
                      _rememberMe = state.rememberMe;
                      if (state.userCredentials != null) {
                        _usernameController.text =
                            state.userCredentials!.username;
                        _passwordController.text =
                            state.userCredentials!.password;
                      }
                    });
                  }

                  if (state is LoginError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage.tr()),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }

                  if (state is LoginSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Login Successful!'.tr()),
                        backgroundColor: Colors.green,
                      ),
                    );
                    getIt<OrderQuery>().setOrderQuery({
                      "companyDb": state.user.data?.companyDb,
                      "clientId": state.user.data?.clientId,
                      "companyDbId": state.user.data?.companyDbId,
                    });
                    log(state.user.data!.token.toString());
                    context.read<OrderCubit>().getOpenOrders({
                      "companyDb": state.user.data?.companyDb,
                      "clientId": state.user.data?.clientId,
                      "companyDbId": state.user.data?.companyDbId,
                    });
                    context.pushReplacement('/dashboard');
                  }
                },
                builder: (context, state) {
                  final isLoading = state is LoginLoading;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LogoImage(
                        cardWidth: cardWidth,
                        logoAnimation: _logoAnimation,
                      ),
                      SizedBox(height: utilities.vSpace(2)),
                      Card(
                        child: Container(
                          width: cardWidth,
                          constraints: const BoxConstraints(maxWidth: 500),
                          padding: EdgeInsets.all(utilities.isTablet ? 32 : 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Login'.tr(),
                                textAlign: TextAlign.center,
                                style: utilities.textTheme.headlineSmall,
                              ).animate().slideY(
                                duration: 500.ms,
                                curve: Curves.easeOut,
                              ),

                              InputColumn(
                                databaseNameController: _databaseNameController,
                                usernameController: _usernameController,
                                passwordController: _passwordController,
                                obscureText: _obscureText,
                              ),
                              SizedBox(height: utilities.vSpace(1)),
                              Row(
                                children: [
                                  Expanded(
                                    child: LoginButton(
                                      isLoading: isLoading,
                                      onPressed: _login,
                                    ),
                                  ),
                                  isLoading ? SizedBox.shrink() : QuickLogin(),
                                ],
                              ).animate().fadeIn(delay: 500.ms),
                              SizedBox(height: utilities.vSpace(1.5)),

                              // ForgotPassword(
                              //   isLoading: isLoading,
                              //   forgotPassword: () {
                              //   }
                              // ),
                              // SizedBox(height: utilities.vSpace(0.5)),
                              Center(child: LanguageSwitcher()),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _databaseNameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _logoAnimationController.dispose();
    super.dispose();
  }
}
