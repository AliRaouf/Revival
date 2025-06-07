import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/features/login/presentation/views/widgets/forgot_password.dart';
import 'package:revival/features/login/presentation/views/widgets/input_column.dart';
import 'package:revival/features/login/presentation/views/widgets/login_button.dart';
import 'package:revival/features/login/presentation/views/widgets/quick_login.dart';
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

    // context.read<LoginCubit>().loadSavedCredentials();

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
    if (_formKey.currentState?.validate() ?? false) {
      final userCredentials = UserCredentials(
        username: _usernameController.text,
        password: _passwordController.text,
      );

      context.read<LoginCubit>().login(
        userCredentials: userCredentials,
        rememberMe: _rememberMe,
      );
    }
  }

  void _forgotPassword() {
    print('Forgot Password tapped');
  }

  @override
  Widget build(BuildContext context) {
    final utilities = Utilities(context);

    final cardWidth =
        utilities.isTablet ? 500.0 : utilities.screenSize.width * 0.9;

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
                        content: Text('Error: ${state.errorMessage}'.tr()),
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

                              ForgotPassword(
                                isLoading: isLoading,
                                forgotPassword: _forgotPassword,
                              ),
                              SizedBox(height: utilities.vSpace(0.5)),
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
