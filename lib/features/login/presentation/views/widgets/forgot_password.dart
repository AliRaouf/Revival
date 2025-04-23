import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({
    super.key,
    required this.textScale,
  });

  final double textScale;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          // Implement forgot password logic
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Forgot Password functionality not implemented yet.')),
          );
        },
        child: Text(
          'Forgot Password?',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: const Color(0xFF6B7280),
            fontSize: 12.8 * textScale,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
