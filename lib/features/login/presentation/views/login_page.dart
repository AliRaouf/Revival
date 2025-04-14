import 'package:flutter/material.dart';
import 'package:revival/features/dashboard/presentation/views/dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;

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
              // Logo
              Image.network(
                'https://revival-me.com/new2/wp-content/uploads/2020/05/Revival-transparent.png',
                width: cardWidth * 0.45,
                fit: BoxFit.contain,
              ),

              // Login Card
              Container(
                width: cardWidth,
                constraints: const BoxConstraints(maxWidth: 500),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x19000000),
                      blurRadius: 6,
                      offset: Offset(0, 4),
                      spreadRadius: -1,
                    ),
                    BoxShadow(
                      color: Color(0x19000000),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                      spreadRadius: -2,
                    ),
                  ],
                ),
                padding: EdgeInsets.all(isTablet ? 32 : 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Title
                    Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(
                        color: const Color(0xFF17405E),
                        fontSize: 20.4 * textScale,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: vSpace(1.5)),

                    // -- Database Name --
                    _buildLabeledField(
                      context,
                      label: 'Database Name',
                      textScale: textScale,
                    ),

                    SizedBox(height: vSpace(1.25)),

                    // -- Username --
                    _buildLabeledField(
                      context,
                      label: 'Username',
                      textScale: textScale,
                    ),

                    SizedBox(height: vSpace(1.25)),

                    // -- Password --
                    _buildLabeledField(
                      context,
                      label: 'Password',
                      textScale: textScale,
                      obscureText: _obscureText,
                      suffix: IconButton(
                        iconSize: 24,
                        splashRadius: 24,
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),

                    SizedBox(height: vSpace(1.25)),

                    // -- Login Button --
                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const DashBoard(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF17405E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          minimumSize: const Size.fromHeight(48),
                        ),
                        child: Text(
                          'Login',
                          style: Theme.of(
                            context,
                          ).textTheme.labelLarge?.copyWith(
                            color: Colors.white,
                            fontSize: 13.6 * textScale,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabeledField(
    BuildContext context, {
    required String label,
    required double textScale,
    bool obscureText = false,
    Widget? suffix,
  }) {
    final labelStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
      color: const Color(0xFF374151),
      fontSize: 11.9 * textScale,
      fontWeight: FontWeight.w500,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: labelStyle),
        const SizedBox(height: 4),
        TextFormField(
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 17,
              vertical: 13,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
            suffixIcon:
                suffix != null
                    ? SizedBox(
                      width: 48,
                      height: 48,
                      child: Center(child: suffix),
                    )
                    : null,
          ),
        ),
      ],
    );
  }
}
