import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import flutter_bloc
import 'package:revival/core/failures/failures.dart'; // Assuming Failures class exists
import 'package:revival/core/theme/theme.dart'; // Assuming this contains scaffoldBackgroundColor
import 'package:revival/core/widgets/logo_image.dart'; // Assuming this exists and is styled appropriately
import 'package:revival/features/dashboard/presentation/views/dashboard_page.dart';
import 'package:revival/features/login/domain/entities/user_creds.dart'; // Import UserCredentials
import 'package:revival/features/login/presentation/cubit/login_cubit.dart'; // Import your LoginCubit
import 'package:revival/features/login/presentation/views/widgets/labeled_field.dart'; // Keep using the refactored labeled_field
// Remove SharedPreferences import as logic is moved to repo/usecase
// import 'package:shared_preferences/shared_preferences.dart';

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
  bool _rememberMe =
      false; // This state is now primarily managed by the Cubit, but kept for the checkbox UI
  late AnimationController _logoAnimationController;
  late Animation<double> _logoAnimation;

  // Form Key for potential validation
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Access the Cubit and load saved credentials when the page initializes
    // This will trigger the listener when the CredentialsLoaded state is emitted.
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

  // --- Login Logic using Cubit ---
  void _login() async {
    // Optional: Add form validation
    if (_formKey.currentState?.validate() ?? false) {
      // Create UserCredentials object from text field values
      final userCredentials = UserCredentials(
        // Corrected property names to match your provided UserCredentials structure
        dbName: _databaseNameController.text,
        username: _usernameController.text,
        password: _passwordController.text,
      );

      // Call the login method on the Cubit.
      // The Cubit will handle the login logic, emit states, and the listener
      // will react to those states for side effects (snackbar, navigation).
      // We no longer await the result here to avoid double handling.
      context.read<LoginCubit>().login(
        userCredentials: userCredentials,
        rememberMe: _rememberMe, // Use the current state of the checkbox
      );

      // Removed the result.fold block from here.
      // The listener in the BlocConsumer will handle success/failure.
    }
  }

  // Placeholder for forgot password logic
  void _forgotPassword() {
    // Implement forgot password logic here, possibly using a Cubit method
    print('Forgot Password tapped');
    // Example: context.read<LoginCubit>().forgotPassword(dbname, username);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get theme data
    final textTheme = theme.textTheme; // Get text theme
    final colorScheme = theme.colorScheme; // Get color scheme

    final mq = MediaQuery.of(context);
    final screenSize = mq.size;
    final isTablet = screenSize.width > 600;
    final cardWidth =
        isTablet ? 500.0 : screenSize.width * 0.9; // Adjusted width
    double vSpace(double factor) => 16 * factor; // Keep local spacing helper

    return Scaffold(
      body: Container(
        color:
            scaffoldBackgroundColor, // Assuming this color exists in your theme.dart
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 24 : 16,
              vertical: isTablet ? 32 : 20, // Adjusted vertical padding
            ),
            child: Form(
              key: _formKey,
              // Use BlocConsumer to listen to state changes and rebuild UI
              // The state type should be the base state class of your Cubit
              child: BlocConsumer<LoginCubit, LoginCubitState>(
                // Use LoginState as the type
                listener: (context, state) {
                  // Listener is good for side effects like showing Snackbars or navigation
                  if (state is CredentialsSuccess) {
                    // Use CredentialsLoaded state name
                    // Populate fields if credentials were loaded
                    _rememberMe = state.rememberMe;
                    if (state.userCredentials != null) {
                      // Use credentials property name
                      _databaseNameController.text =
                          state
                              .userCredentials!
                              .dbName; // Use dbname property name
                      _usernameController.text =
                          state
                              .userCredentials!
                              .username; // Use username property name
                      _passwordController.text =
                          state
                              .userCredentials!
                              .password; // Use password property name
                    }
                    // Update the UI state for the checkbox
                    setState(() {});
                  }
                  // Handle LoginError state
                  if (state is LoginError) {
                    // Show error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Error: ${state.errorMessage}',
                        ), // Use message property name
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }
                  // Handle LoginSuccess state
                  if (state is LoginSuccess) {
                    // Navigate to dashboard or show success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Login Successful!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    // Navigate after showing the snackbar
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => DashBoard()),
                    ); // Use named route
                  }
                },
                builder: (context, state) {
                  // Builder is where you build the UI based on the current state
                  // Check if the state is LoginLoading to show a progress indicator
                  final isLoading = state is LoginLoading;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Assuming LogoImage uses theme or is self-contained
                      LogoImage(
                        cardWidth: cardWidth,
                        logoAnimation: _logoAnimation,
                      ),
                      SizedBox(height: vSpace(2)),
                      Card(
                        child: Container(
                          // Use Container for padding inside the card
                          width: cardWidth, // Constrain width here if needed
                          constraints: const BoxConstraints(
                            maxWidth: 500,
                          ), // Max width constraint
                          padding: EdgeInsets.all(isTablet ? 32 : 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Animated Title using TextTheme
                              Text(
                                'Login',
                                textAlign: TextAlign.center,
                                style:
                                    textTheme
                                        .headlineSmall, // Use theme style directly
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

                              // -- Username --
                              LabeledField(
                                label: 'Username (SAP Customer Code)',
                                controller: _usernameController,
                                keyboardType:
                                    TextInputType
                                        .visiblePassword, // Assuming this is correct type
                                validator:
                                    (value) =>
                                        value == null || value.isEmpty
                                            ? 'Username is required'
                                            : null,
                              ).animate().fadeIn(delay: 200.ms),

                              SizedBox(height: vSpace(1.5)),

                              // -- Password --
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
                                  iconSize: 24, // Slightly smaller icon
                                  splashRadius: 24,
                                  color: theme.iconTheme.color?.withOpacity(
                                    0.7,
                                  ), // Use theme icon color
                                  icon: Icon(
                                    _obscureText
                                        ? Icons
                                            .visibility_off_outlined // Use outlined icons
                                        : Icons.visibility_outlined,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                ),
                              ).animate().fadeIn(delay: 300.ms),

                              SizedBox(
                                height: vSpace(0.5),
                              ), // Reduced space before checkbox
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    value: _rememberMe,
                                    onChanged:
                                        isLoading
                                            ? null
                                            : (bool? value) {
                                              // Disable checkbox while loading
                                              setState(() {
                                                _rememberMe = value ?? false;
                                              });
                                            },

                                    visualDensity:
                                        VisualDensity
                                            .compact, // Make checkbox smaller
                                  ),
                                  InkWell(
                                    onTap:
                                        isLoading
                                            ? null
                                            : () {
                                              // Disable InkWell while loading
                                              setState(() {
                                                _rememberMe = !_rememberMe;
                                              });
                                            },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                      ), // Add padding for easier tap
                                      child: Text(
                                        'Remember Me',
                                        // Use theme text style
                                        style: textTheme.bodyMedium?.copyWith(
                                          color:
                                              isLoading
                                                  ? theme.disabledColor
                                                  : textTheme
                                                      .bodyMedium
                                                      ?.color, // Grey out text when disabled
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ).animate().fadeIn(delay: 400.ms),

                              SizedBox(height: vSpace(1.5)), // Adjusted space
                              SizedBox(
                                height: 52,
                                child:
                                    ElevatedButton(
                                          // Disable button while loading
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
                                                  ) // Show loading indicator
                                                  : Text(
                                                    'Login',
                                                    // Text style comes from ElevatedButtonThemeData
                                                  ),
                                        )
                                        .animate(delay: 500.ms)
                                        .scale(
                                          duration: 200.ms,
                                          curve: Curves.easeInOut,
                                        )
                                        .fade(),
                              ),

                              SizedBox(height: vSpace(1.5)), // Adjusted space
                              // -- Forgot Password (Integrated from forgot_password.dart) --
                              Center(
                                child: TextButton(
                                  onPressed:
                                      isLoading
                                          ? null
                                          : _forgotPassword, // Disable while loading
                                  child: Text(
                                    'Forgot Password?',
                                    // Use theme text style, maybe bodySmall for less emphasis
                                    style: textTheme.bodySmall?.copyWith(
                                      color:
                                          isLoading
                                              ? theme.disabledColor
                                              : colorScheme
                                                  .primary, // Grey out text when disabled
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
