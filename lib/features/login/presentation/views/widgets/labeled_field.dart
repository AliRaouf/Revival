import 'package:flutter/material.dart';
import 'package:revival/core/theme/theme.dart';
// Import theme constants for specific styles if needed

// Changed to a StatefulWidget to manage focus state for label color if needed
class LabeledField extends StatefulWidget {
  final String label;
  final bool obscureText;
  final Widget? suffix;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator; // Added validator parameter
  final bool useUnderlineBorder; // Flag to switch between underline and outline

  const LabeledField({
    super.key,
    required this.label,
    this.obscureText = false,
    this.suffix,
    this.controller,
    this.keyboardType,
    this.validator,
    this.useUnderlineBorder = true, // Default to underline for login page
  });

  @override
  State<LabeledField> createState() => _LabeledFieldState();
}

class _LabeledFieldState extends State<LabeledField> {
  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _hasFocus = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    // Determine label style based on focus
    final labelStyle = textTheme.bodySmall?.copyWith(
      fontWeight: FontWeight.w600, // Keep specific weight for label
      color:
          _hasFocus
              ? colorScheme.primary
              : colorScheme.onBackground.withOpacity(0.7),
    );

    // Choose decoration based on the flag
    final InputDecoration inputDecoration =
        widget.useUnderlineBorder
            ? koutlineInputDecoration // Use the specific underline style from theme
            : const InputDecoration(); // Use a default InputDecoration instance

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: labelStyle),
        const SizedBox(height: 6), // Keep specific spacing for label
        TextFormField(
          focusNode: _focusNode,
          controller: widget.controller,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          validator: widget.validator, // Pass validator
          // Use theme's InputDecorationTheme and apply overrides
          decoration: inputDecoration.copyWith(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kDefaultBorderRadius),
              borderSide: BorderSide(
                color:
                    _hasFocus
                        ? colorScheme.primary
                        : colorScheme.onBackground.withOpacity(0.7),
                width: 2,
              ),
            ),
            // Apply suffix icon if provided
            suffixIcon: SizedBox(
              width: 24,
              height: 24,
              child: Center(child: widget.suffix ?? const SizedBox()),
            ),

            // Override hint/label text if needed, but usually handled by TextFormField
            // hintText: 'Optional hint',
            // labelText: widget.label, // Usually not needed with external label
          ),
          // Apply text style from theme for the input itself
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurface, // Ensure input text color is correct
          ),
        ),
      ],
    );
  }
}
