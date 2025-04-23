import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // Import the flutter_animate package
import 'package:revival/core/custom/logo_image.dart';
import 'package:revival/features/dashboard/presentation/views/dashboard_page.dart';
import 'package:revival/features/login/presentation/views/components/labeled_field.dart';
import 'package:revival/features/login/presentation/views/widgets/forgot_password.dart';
import 'package:revival/features/login/presentation/views/widgets/login_button.dart';
import 'package:revival/features/login/presentation/views/widgets/remember_me.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For remembering login details

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

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
    _logoAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward(); // Start the animation on load

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

  Future<void> _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _rememberMe = prefs.getBool('rememberMe') ?? false;
      if (_rememberMe) {
        _databaseNameController.text = prefs.getString('databaseName') ?? '';
        _usernameController.text = prefs.getString('username') ?? '';
        _passwordController.text = prefs.getString('password') ?? '';
      }
    });
  }

  Future<void> _saveCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberMe', _rememberMe);
    if (_rememberMe) {
      await prefs.setString('databaseName', _databaseNameController.text);
      await prefs.setString('username', _usernameController.text);
      await prefs.setString('password', _passwordController.text);
    } else {
      await prefs.remove('databaseName');
      await prefs.remove('username');
      await prefs.remove('password');
    }
  }

  void _login() {
    // In a real application, you would authenticate with your backend here.
    // For this example, we'll just navigate to the dashboard.
    _saveCredentials(); // Save credentials on login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const DashBoard()),
    );
    // You might want to add error handling and loading states here.
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final screenSize = mq.size;
    final textScale = mq.textScaleFactor;
    final isTablet = screenSize.width > 600;
    final cardWidth = isTablet ? 500.0 : screenSize.width * 0.88;
    double vSpace(double factor) => 16 * factor;
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 24 : 16,
            vertical: isTablet ? 32 : 16,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Enhanced Logo with Animation
             LogoImage(cardWidth: cardWidth, logoAnimation: _logoAnimation),
              SizedBox(height: vSpace(2)),

              // Login Card with Subtle Animation
              Container(
                width: cardWidth,
                constraints: const BoxConstraints(maxWidth: 500),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x19000000),
                      blurRadius: 8, // Slightly more pronounced shadow
                      offset: Offset(0, 6), // Deeper shadow
                      spreadRadius: -2, // More subtle spread
                    ),
                    BoxShadow(
                      color: Color(0x19000000),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                      spreadRadius: -3,
                    ),
                  ],
                ),
                padding: EdgeInsets.all(isTablet ? 32 : 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Animated Title
                    Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: const Color(0xFF17405E),
                        fontSize: 22.0 * textScale, // Slightly larger title
                        fontWeight: FontWeight.w700, // More prominent weight
                      ),
                    ).animate().slideY(duration: 500.ms, curve: Curves.easeOut),

                    SizedBox(height: vSpace(2)),

                    // -- Database Name --
                    buildLabeledField(
                      context,
                      label: 'Database Name',
                      textScale: textScale,
                      controller: _databaseNameController,
                      keyboardType: TextInputType.url, // Hint for database name
                    ).animate().fadeIn(delay: 100.ms),

                    SizedBox(height: vSpace(1.5)),

                    // -- Username --
                    buildLabeledField(
                      context,
                      label: 'Username (SAP Customer Code)',
                      textScale: textScale,
                      controller: _usernameController,
                      keyboardType: TextInputType.visiblePassword, // Could be alphanumeric
                    ).animate().fadeIn(delay: 200.ms),

                    SizedBox(height: vSpace(1.5)),

                    // -- Password --
                    buildLabeledField(
                      context,
                      label: 'Password',
                      textScale: textScale,
                      obscureText: _obscureText,
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      suffix: IconButton(
                        iconSize: 26, // Slightly larger icon
                        splashRadius: 26,
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off_rounded
                              : Icons.visibility_rounded, // More modern icons
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ).animate().fadeIn(delay: 300.ms),

                    SizedBox(height: vSpace(1.75)),

                    // -- Remember Me Checkbox --
                    RememberMe(rememberMe: _rememberMe,textScale: textScale).animate().fadeIn(delay: 400.ms),

                    SizedBox(height: vSpace(2)),

                    // -- Animated Login Button with Feedback --
                    LoginButton(textScale: textScale, onPressed: _login),

                    SizedBox(height: vSpace(2)),

                    // -- Forgot Password (Optional) --
                    ForgotPassword(textScale: textScale).animate().fadeIn(delay: 600.ms),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

