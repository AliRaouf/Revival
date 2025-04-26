import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:revival/shared/utils.dart';

class LoginButton extends StatelessWidget {
  void Function()? onPressed;
  final bool isLoading;
  final void Function()? login;
  LoginButton({super.key, this.onPressed, required this.isLoading, this.login});
  @override
  Widget build(BuildContext context) {
    final utilities = Utilities(context);
    return SizedBox(
      height: 52,
      child:
          ElevatedButton(
                onPressed: isLoading ? null : login,
                style: utilities.theme.elevatedButtonTheme.style?.copyWith(
                  minimumSize: WidgetStateProperty.all(
                    const Size.fromHeight(52),
                  ),
                ),
                child:
                    isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text('Login'),
              )
              .animate(delay: 500.ms)
              .scale(duration: 200.ms, curve: Curves.easeInOut)
              .fade(),
    );
  }
}
