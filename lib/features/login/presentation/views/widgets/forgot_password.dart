import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:revival/shared/utils.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({
    super.key,
    required this.forgotPassword,
    required this.isLoading,
  });
  final bool isLoading;
  final void Function()? forgotPassword;

  @override
  Widget build(BuildContext context) {
    final utilities = Utilities(context);
    return Center(
      child: TextButton(
        onPressed: isLoading ? null : forgotPassword,
        child: Text(
          'ForgotPassword'.tr(),

          style: utilities.textTheme.bodySmall?.copyWith(
            color:
                isLoading
                    ? utilities.theme.disabledColor
                    : utilities.colorScheme.primary,
          ),
        ),
      ),
    ).animate().fadeIn(delay: 600.ms);
  }
}
