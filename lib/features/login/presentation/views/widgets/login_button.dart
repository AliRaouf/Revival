import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/shared/utils.dart'; // Assuming this holds your color definitions like primaryColor

class LoginButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const LoginButton({super.key, this.onPressed, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    final utilities = Utilities(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return ElevatedButton(
          style: _buildButtonStyle(utilities, isArabic),
          onPressed: isLoading ? null : onPressed,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(scale: animation, child: child),
              );
            },
            child: _buildButtonChild(),
          ),
        )
        .animate(delay: 500.ms)
        .fade(duration: 400.ms, curve: Curves.easeIn)
        .slideY(begin: 0.2, end: 0, curve: Curves.easeInOut);
  }

  Widget _buildButtonChild() {
    if (isLoading) {
      return const SizedBox(
        key: ValueKey('loader'),
        height: 24.0,
        width: 24.0,
        child: CircularProgressIndicator(color: primaryColor, strokeWidth: 3.0),
      );
    } else {
      return Text(
        key: const ValueKey('text'),
        'Login'.tr(),
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      );
    }
  }

  /// Constructs the button's style for use within a Row.
  ButtonStyle _buildButtonStyle(Utilities utilities, bool isArabic) {
    // This border radius logic ensures the outer corners are rounded
    // and inner corners (next to the other button) are straight.
    final BorderRadius borderRadius =
        isArabic
            ? isLoading
                ? const BorderRadius.all(Radius.circular(12))
                : const BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                )
            : isLoading
            ? const BorderRadius.all(Radius.circular(12))
            : const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            );

    return utilities.theme.elevatedButtonTheme.style?.copyWith(
          // Set a fixed height, but the width is flexible because it's in an Expanded widget.
          minimumSize: WidgetStateProperty.all(const Size(0, 54)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: borderRadius),
          ),
          elevation: WidgetStateProperty.all(2.0),
        ) ??
        ElevatedButton.styleFrom(
          minimumSize: const Size(0, 54),
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          elevation: 2.0,
        );
  }
}
