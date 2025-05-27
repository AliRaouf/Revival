import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/shared/utils.dart';

class LoginButton extends StatelessWidget {
  final void Function()? onPressed;
  final bool isLoading;
  final void Function()? login;
  const LoginButton({
    super.key,
    this.onPressed,
    required this.isLoading,
    this.login,
  });
  @override
  Widget build(BuildContext context) {
    final utilities = Utilities(context);
    return ElevatedButton(
          onPressed: isLoading ? null : login,
          style: utilities.theme.elevatedButtonTheme.style?.copyWith(
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: Localizations.localeOf(context).languageCode == 'ar'?BorderRadius.only(
                bottomRight: Radius.circular(8),
                topRight: Radius.circular(8)) :BorderRadius.only(
                bottomLeft: Radius.circular(8),
                topLeft: Radius.circular(8),
                ),
              ),
            ),
            minimumSize: WidgetStateProperty.all(const Size.fromHeight(52)),
          ),
          child:
              isLoading
                  ? SizedBox(
                    height: 24,
                    child: const CircularProgressIndicator(color: primaryColor),
                  )
                  : Text('Login'.tr()),
        )
        .animate(delay: 500.ms)
        .scale(duration: 200.ms, curve: Curves.easeInOut)
        .fade();
  }
}
