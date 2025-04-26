import 'package:flutter/material.dart';
import 'package:revival/shared/utils.dart';

class BusinessPartnerDropdown extends StatelessWidget {
  final String label;
  final String hint;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validator;
  final List<DropdownMenuItem<String>> getLocalizedDropdownItems;
  const BusinessPartnerDropdown({
    super.key,
    required BuildContext context, // Added context
    required this.label,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validator, required this.getLocalizedDropdownItems,
  });

  @override
  Widget build(BuildContext context) {
    final utilities = Utilities(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: DropdownButtonFormField<String>(
        value: value,
        isExpanded: true,
        hint: Text(
          hint,
          // Use a slightly less prominent color for hint
          style: utilities.textTheme.bodyMedium?.copyWith(
            color: utilities.textTheme.bodyMedium?.color?.withOpacity(0.7),
            fontSize: 15,
          ),
        ),
        // Use theme's onSurface color for text
        style: utilities.textTheme.bodyMedium?.copyWith(
          color: utilities.colorScheme.onSurface,
          fontSize: 15,
        ),
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          // Use a slightly less prominent color for label
          labelStyle: utilities.textTheme.bodyMedium?.copyWith(
            color: utilities.textTheme.bodyMedium?.color?.withOpacity(0.7),
            fontSize: 15,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 12.0,
          ),
          border: OutlineInputBorder(
            // Use theme's divider color for border
            borderSide: BorderSide(color: utilities.theme.dividerColor),
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            // Use theme's divider color for enabled border
            borderSide: BorderSide(color: utilities.theme.dividerColor),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            // Use theme's primary color for focused border
            borderSide: BorderSide(
              color: utilities.colorScheme.primary,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: utilities.theme.colorScheme.error,
              width: 1.0,
            ), // Use theme's error color
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: utilities.theme.colorScheme.error,
              width: 1.5,
            ), // Use theme's error color
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          // Use theme's surface color for fill color
          fillColor: utilities.colorScheme.surface,
        ),
        items: getLocalizedDropdownItems, // Use localized items
        onChanged: onChanged,
        // Use a subtle color for the dropdown icon
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: utilities.textTheme.bodyMedium?.color?.withOpacity(0.6),
        ),
        // Use theme's surface color for dropdown menu background
        dropdownColor: utilities.colorScheme.surface,
      ),
    );
  }
}
