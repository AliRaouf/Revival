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

  const LabeledField({
    super.key,
    required this.label,
    this.obscureText = false,
    this.suffix,
    this.controller,
    this.keyboardType,
    this.validator,
    this.useUnderlineBorder = true,
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

    final labelStyle = textTheme.bodySmall?.copyWith(
      fontWeight: FontWeight.w600,
      color:
          _hasFocus
              ? colorScheme.primary
              : colorScheme.onBackground.withOpacity(0.7),
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
          focusNode: _focusNode,
          controller: widget.controller,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          validator: widget.validator,

          decoration: inputDecoration.copyWith(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
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
