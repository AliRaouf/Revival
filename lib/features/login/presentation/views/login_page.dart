import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/core/widgets/logo_image.dart';
import 'package:revival/features/dashboard/presentation/views/dashboard_page.dart';
import 'package:revival/features/login/domain/entities/user_creds.dart';
import 'package:revival/features/login/presentation/cubit/login_cubit.dart';
import 'package:revival/features/login/presentation/views/widgets/labeled_field.dart';

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
  bool _rememberMe = false;
  late AnimationController _logoAnimationController;
  late Animation<double> _logoAnimation;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    context.read<LoginCubit>().loadSavedCredentials();

    _logoAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();

    _logoAnimation = CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.easeInOut,
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

  void _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      final userCredentials = UserCredentials(
        dbName: _databaseNameController.text,
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
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final mq = MediaQuery.of(context);
    final screenSize = mq.size;
    final isTablet = screenSize.width > 600;
    final cardWidth = isTablet ? 500.0 : screenSize.width * 0.9;
    double vSpace(double factor) => 16 * factor;

    return Scaffold(
      body: Container(
        color: scaffoldBackgroundColor,
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 24 : 16,
              vertical: isTablet ? 32 : 20,
            ),
            child: Form(
              key: _formKey,

              child: BlocConsumer<LoginCubit, LoginCubitState>(
                listener: (context, state) {
                  if (state is CredentialsSuccess) {
                    _rememberMe = state.rememberMe;
                    if (state.userCredentials != null) {
                      _databaseNameController.text =
                          state.userCredentials!.dbName;
                      _usernameController.text =
                          state.userCredentials!.username;
                      _passwordController.text =
                          state.userCredentials!.password;
                    }

                    setState(() {});
                  }

                  if (state is LoginError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: ${state.errorMessage}'),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }

                  if (state is LoginSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Login Successful!'),
                        backgroundColor: Colors.green,
                      ),
                    );

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => DashBoard()),
                    );
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
                      SizedBox(height: vSpace(2)),
                      Card(
                        child: Container(
                          width: cardWidth,
                          constraints: const BoxConstraints(maxWidth: 500),
                          padding: EdgeInsets.all(isTablet ? 32 : 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Login',
                                textAlign: TextAlign.center,
                                style: textTheme.headlineSmall,
                              ).animate().slideY(
                                duration: 500.ms,
                                curve: Curves.easeOut,
                              ),

                              SizedBox(height: vSpace(2)),

                              LabeledField(
                                label: 'Database Name',
                                controller: _databaseNameController,
                                keyboardType: TextInputType.url,
                                validator:
                                    (value) =>
                                        value == null || value.isEmpty
                                            ? 'Database Name is required'
                                            : null,
                              ).animate().fadeIn(delay: 100.ms),

                              SizedBox(height: vSpace(1.5)),

                              LabeledField(
                                label: 'Username (SAP Customer Code)',
                                controller: _usernameController,
                                keyboardType: TextInputType.visiblePassword,
                                validator:
                                    (value) =>
                                        value == null || value.isEmpty
                                            ? 'Username is required'
                                            : null,
                              ).animate().fadeIn(delay: 200.ms),

                              SizedBox(height: vSpace(1.5)),

                              LabeledField(
                                label: 'Password',
                                obscureText: _obscureText,
                                controller: _passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                validator:
                                    (value) =>
                                        value == null || value.isEmpty
                                            ? 'Password is required'
                                            : null,
                                suffix: IconButton(
                                  iconSize: 24,
                                  splashRadius: 24,
                                  color: theme.iconTheme.color?.withOpacity(
                                    0.7,
                                  ),
                                  icon: Icon(
                                    _obscureText
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                ),
                              ).animate().fadeIn(delay: 300.ms),

                              SizedBox(height: vSpace(0.5)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    value: _rememberMe,
                                    onChanged:
                                        isLoading
                                            ? null
                                            : (bool? value) {
                                              setState(() {
                                                _rememberMe = value ?? false;
                                              });
                                            },

                                    visualDensity: VisualDensity.compact,
                                  ),
                                  InkWell(
                                    onTap:
                                        isLoading
                                            ? null
                                            : () {
                                              setState(() {
                                                _rememberMe = !_rememberMe;
                                              });
                                            },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                      ),
                                      child: Text(
                                        'Remember Me',

                                        style: textTheme.bodyMedium?.copyWith(
                                          color:
                                              isLoading
                                                  ? theme.disabledColor
                                                  : textTheme.bodyMedium?.color,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ).animate().fadeIn(delay: 400.ms),

                              SizedBox(height: vSpace(1.5)),
                              SizedBox(
                                height: 52,
                                child:
                                    ElevatedButton(
                                          onPressed: isLoading ? null : _login,
                                          style: theme.elevatedButtonTheme.style
                                              ?.copyWith(
                                                minimumSize:
                                                    WidgetStateProperty.all(
                                                      const Size.fromHeight(52),
                                                    ),
                                              ),
                                          child:
                                              isLoading
                                                  ? const CircularProgressIndicator(
                                                    color: Colors.white,
                                                  )
                                                  : Text('Login'),
                                        )
                                        .animate(delay: 500.ms)
                                        .scale(
                                          duration: 200.ms,
                                          curve: Curves.easeInOut,
                                        )
                                        .fade(),
                              ),

                              SizedBox(height: vSpace(1.5)),

                              Center(
                                child: TextButton(
                                  onPressed: isLoading ? null : _forgotPassword,
                                  child: Text(
                                    'Forgot Password?',

                                    style: textTheme.bodySmall?.copyWith(
                                      color:
                                          isLoading
                                              ? theme.disabledColor
                                              : colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ).animate().fadeIn(delay: 600.ms),
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
}
