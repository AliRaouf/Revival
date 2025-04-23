import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoginButton extends StatelessWidget {
  void Function()? onPressed;
  final double textScale;
   LoginButton({super.key, required this.textScale,this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52, // Slightly taller button
      child:
          ElevatedButton(
                onPressed: onPressed, // Use the _login function
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF17405E),
                  elevation: 3, // Add a subtle elevation
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // More rounded
                  ),
                  minimumSize: const Size.fromHeight(52),
                ),
                child: Text(
                  'Login',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                    fontSize: 14.4 * textScale, // Slightly larger text
                    fontWeight: FontWeight.w600, // More prominent weight
                  ),
                ),
              )
              .animate(delay: 500.ms)
              .scale(duration: 200.ms, curve: Curves.easeInOut)
              .fade(),
    );
  }
}
