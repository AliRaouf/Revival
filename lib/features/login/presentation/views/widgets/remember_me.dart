// login/presentation/views/widgets/remember_me.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:revival/shared/utils.dart';

class RememberMe extends StatelessWidget { // Changed to StatelessWidget
  final bool rememberMe;
  final ValueChanged<bool?>? onChanged; // Added onChanged callback
  final Utilities utilities;
  final bool isLoading;

  const RememberMe({ // Use const constructor
    super.key,
    required this.rememberMe,
    required this.onChanged, // Require the callback
    required this.utilities,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: rememberMe, // Use the passed value directly
          onChanged: isLoading ? null : onChanged, // Use the callback
          visualDensity: VisualDensity.compact,
        ),
        InkWell(
          onTap: isLoading ? null : () => onChanged?.call(!rememberMe), // Use callback
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'RememberMe'.tr(), // Assuming localization setup
              style: utilities.textTheme.bodyMedium?.copyWith(
                color: isLoading
                    ? utilities.theme.disabledColor
                    : utilities.textTheme.bodyMedium?.color,
              ),
            ),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 400.ms);
  }
}