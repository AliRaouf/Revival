import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revival/features/login/presentation/cubit/login_cubit.dart';
import 'package:revival/shared/utils.dart';

class QuickLogin extends StatelessWidget {
  const QuickLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final utilities = Utilities(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return SizedBox(
      height: 54, // Match the height of the main LoginButton
      child: IconButton(
        style: _buildQuickLoginButtonStyle(utilities, isArabic),
        onPressed: () {
          final cubit = context.read<LoginCubit>();
          cubit.attemptBiometricLogin();
        },
        icon: const Icon(Icons.fingerprint),
      ),
    );
  }

  /// Constructs the button's style to pair with the LoginButton.
  ButtonStyle _buildQuickLoginButtonStyle(Utilities utilities, bool isArabic) {
    // This border radius mirrors the LoginButton for a cohesive look.
    final BorderRadius borderRadius =
        isArabic
            ? const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            )
            : const BorderRadius.only(
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
            );

    return IconButton.styleFrom(
      minimumSize: const Size.square(54),
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      side: BorderSide(color: utilities.theme.colorScheme.primary, width: 1.5),
      backgroundColor: utilities.theme.colorScheme.surface,
    );
  }
}
