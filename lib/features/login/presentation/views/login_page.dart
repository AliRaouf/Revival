import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:revival/core/services/service_locator.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/core/utils/toast_utils.dart';
import 'package:revival/features/business_partners/presentation/cubit/business_partner_cubit.dart';
import 'package:revival/features/login/domain/entities/auth_token.dart';
import 'package:revival/features/login/presentation/views/widgets/fingerprint_button.dart';
import 'package:revival/features/order/presentation/cubit/open_order/order_cubit.dart';
import 'package:revival/shared/utils.dart';
import 'package:revival/shared/logo_image.dart';
import 'package:revival/features/login/domain/entities/user_creds.dart';
import 'package:revival/features/login/presentation/cubit/login_cubit.dart';
import 'package:revival/features/login/presentation/views/widgets/language_switcher.dart';
import 'package:revival/features/login/presentation/views/widgets/labeled_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/widgets.dart' as flutter;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  bool _obscureText = true;
  final _databaseNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
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
      ToastUtils.showErrorToast(
        context,
        'No internet connection. Please check your network settings.'.tr(),
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
        rememberMe: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final utilities = Utilities(context);
    final cardWidth = utilities.isTablet ? 420.0 : 360.0;
    return Scaffold(
      body: Container(
        color: scaffoldBackgroundColor,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LogoImage(cardWidth: cardWidth, logoAnimation: _logoAnimation),
                const SizedBox(height: 24),
                Card(
                  elevation: 1.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Container(
                    width: cardWidth,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 32,
                    ),
                    child: Form(
                      key: _formKey,
                      child: BlocConsumer<LoginCubit, LoginCubitState>(
                        listener: (context, state) {
                          if (state is CredentialsSuccess) {
                            setState(() {
                              if (state.userCredentials != null) {
                                _usernameController.text =
                                    state.userCredentials!.username;
                                _passwordController.text =
                                    state.userCredentials!.password;
                              }
                            });
                          }
                          if (state is LoginError) {
                            ToastUtils.showErrorToast(
                              context,
                              state.errorMessage.tr(),
                            );
                          }
                          if (state is LoginSuccess) {
                            ToastUtils.showSuccessToast(
                              context,
                              'Login Successful!'.tr(),
                            );
                            getIt<OrderQuery>().setOrderQuery({
                              "companyDb": state.user.data?.companyDb,
                              "clientId": state.user.data?.clientId,
                              "companyDbId": state.user.data?.companyDbId,
                            });
                            context.read<OrderCubit>().getOpenOrders({
                              "companyDb": state.user.data?.companyDb,
                              "clientId": state.user.data?.clientId,
                              "companyDbId": state.user.data?.companyDbId,
                            });
                            context
                                .read<BusinessPartnerCubit>()
                                .getBusinessPartners();
                            context.pushReplacement('/dashboard');
                            log(state.user.data!.token.toString());
                          }
                        },
                        builder: (context, state) {
                          final isLoading = state is LoginLoading;
                          return Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Login'.tr(),
                                    textAlign: TextAlign.center,
                                    style: utilities.textTheme.headlineSmall
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 18),
                                  LabeledField(
                                    label: 'DBName'.tr(),
                                    controller: _databaseNameController,
                                    keyboardType: TextInputType.url,
                                    validator:
                                        (value) =>
                                            value == null || value.isEmpty
                                                ? 'Databasenamerequired'.tr()
                                                : null,
                                  ),
                                  const SizedBox(height: 12),
                                  LabeledField(
                                    label: 'Username'.tr(),
                                    controller: _usernameController,
                                    keyboardType: TextInputType.text,
                                    validator:
                                        (value) =>
                                            value == null || value.isEmpty
                                                ? 'UserNameisRequired'.tr()
                                                : null,
                                  ),
                                  const SizedBox(height: 12),
                                  LabeledField(
                                    label: 'Password'.tr(),
                                    obscureText: _obscureText,
                                    controller: _passwordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    validator:
                                        (value) =>
                                            value == null || value.isEmpty
                                                ? 'PasswordisRequired'.tr()
                                                : null,
                                    suffix: IconButton(
                                      icon: Icon(
                                        _obscureText
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                      ),
                                      onPressed:
                                          () => setState(
                                            () => _obscureText = !_obscureText,
                                          ),
                                    ),
                                  ),
                                  const SizedBox(height: 18),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: isLoading ? null : _login,
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
                                        textStyle: utilities
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                        ),
                                      ),
                                      child: Text('Login'.tr()),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  FingerPrintButton(isLoading: isLoading),
                                ],
                              ),
                              if (isLoading)
                                Positioned.fill(
                                  child: Container(
                                    color: Colors.white.withOpacity(0.5),
                                    child: const Center(
                                      child: SpinKitWave(
                                        color: primaryColor,
                                        size: 40.0,
                                      ),
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
                const SizedBox(height: 18),
                Directionality(
                  textDirection: flutter.TextDirection.ltr,
                  child: Center(child: LanguageSwitcher()),
                ),
              ],
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
