import 'package:flutter/material.dart';

Widget buildTextField({
  required BuildContext context, // Added context
  required String label,
  required TextEditingController controller,
  TextInputType? keyboardType,
  String? Function(String?)? validator,
  bool obscureText = false,
}) {
  final theme = Theme.of(context); // Access theme
  final textTheme = theme.textTheme;
  final colorScheme = theme.colorScheme;

  return Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: TextFormField(
      controller: controller,
      // Use theme's onSurface color for text
      style: textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurface,
        fontSize: 15,
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        // Use a slightly less prominent color for label
        labelStyle: textTheme.bodyMedium?.copyWith(
          color: textTheme.bodyMedium?.color?.withOpacity(0.7),
          fontSize: 15,
        ),
        // Use a slightly less prominent color for hint
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: textTheme.bodyMedium?.color?.withOpacity(0.7),
          fontSize: 15,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 12.0,
        ),
        border: OutlineInputBorder(
          // Use theme's divider color for border
          borderSide: BorderSide(color: theme.dividerColor),
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          // Use theme's divider color for enabled border
          borderSide: BorderSide(color: theme.dividerColor),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          // Use theme's primary color for focused border
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: theme.colorScheme.error,
            width: 1.0,
          ), // Use theme's error color
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: theme.colorScheme.error,
            width: 1.5,
          ), // Use theme's error color
          borderRadius: BorderRadius.circular(8.0),
        ),
        filled: true,
        // Use theme's surface color for fill color
        fillColor: colorScheme.surface,
      ),
    ),
  );
}
