import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:revival/shared/utils.dart';

class RememberMe extends StatefulWidget {
  bool rememberMe;
  final Utilities utilities;
  final bool isLoading;
  RememberMe({
    super.key,
    required this.rememberMe,
    required this.utilities,
    required this.isLoading,
  });

  @override
  State<RememberMe> createState() => _RememberMeState();
}

class _RememberMeState extends State<RememberMe> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: widget.rememberMe,
          onChanged:
              widget.isLoading
                  ? null
                  : (bool? value) {
                    setState(() {
                      widget.rememberMe = value ?? false;
                    });
                  },

          visualDensity: VisualDensity.compact,
        ),
        InkWell(
          onTap:
              widget.isLoading
                  ? null
                  : () {
                    setState(() {
                      widget.rememberMe = !widget.rememberMe;
                    });
                  },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'RememberMe',

              style: widget.utilities.textTheme.bodyMedium?.copyWith(
                color:
                    widget.isLoading
                        ? widget.utilities.theme.disabledColor
                        : widget.utilities.textTheme.bodyMedium?.color,
              ),
            ),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 400.ms);
  }
}
