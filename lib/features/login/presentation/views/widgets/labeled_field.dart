import 'package:flutter/material.dart';
import 'package:revival/core/theme/theme.dart';

class LabeledField extends StatefulWidget {
  final String label;
  final bool obscureText;
  final Widget? suffix;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool useUnderlineBorder;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;

  const LabeledField({
    super.key,
    required this.label,
    this.obscureText = false,
    this.suffix,
    this.controller,
    this.keyboardType,
    this.validator,
    this.useUnderlineBorder = true,
    this.textInputAction,
    this.onFieldSubmitted,
    this.focusNode
  });

  @override
  State<LabeledField> createState() => _LabeledFieldState();
}

class _LabeledFieldState extends State<LabeledField> {

  @override

  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final labelStyle = textTheme.bodySmall?.copyWith(
      fontWeight: FontWeight.w600,
      color:
              colorScheme.primary
    );

    final InputDecoration inputDecoration =
        widget.useUnderlineBorder
            ? koutlineInputDecoration
            : const InputDecoration();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: labelStyle),
        const SizedBox(height: 6),
        TextFormField(
          focusNode: widget.focusNode,
          controller: widget.controller,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onFieldSubmitted,
          decoration: inputDecoration.copyWith(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kDefaultBorderRadius),
              borderSide: BorderSide(
                color: colorScheme.primary,
              
                width: 2,
              ),
            ),

            suffixIcon: SizedBox(
              width: 24,
              height: 24,
              child: Center(child: widget.suffix ?? const SizedBox()),
            ),
          ),

          style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
        ),
      ],
    );
  }
}
