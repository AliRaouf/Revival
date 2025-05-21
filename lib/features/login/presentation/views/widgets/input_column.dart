import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:revival/features/login/presentation/views/widgets/labeled_field.dart';
import 'package:revival/shared/utils.dart';

class InputColumn extends StatefulWidget {
  final TextEditingController databaseNameController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  bool obscureText;
  InputColumn({
    super.key,
    required this.databaseNameController,
    required this.usernameController,
    required this.passwordController,
    required this.obscureText,
  });

  @override
  State<InputColumn> createState() => _InputColumnState();
}

class _InputColumnState extends State<InputColumn> {
  @override
  Widget build(BuildContext context) {
    final utilities = Utilities(context);
    return Column(
      children: [
        SizedBox(height: utilities.vSpace(2)),

        LabeledField(
          label: 'DBName'.tr(),
          controller: widget.databaseNameController,
          keyboardType: TextInputType.url,
          validator:
              (value) =>
                  value == null || value.isEmpty
                      ? 'Databasenamerequired'.tr()
                      : null,
        ).animate().fadeIn(delay: 100.ms),

        SizedBox(height: utilities.vSpace(1.5)),

        LabeledField(
          label: 'Username'.tr(),
          controller: widget.usernameController,
          keyboardType: TextInputType.visiblePassword,
          validator:
              (value) =>
                  value == null || value.isEmpty ? 'UserNameisRequired'.tr() : null,
        ).animate().fadeIn(delay: 200.ms),

        SizedBox(height: utilities.vSpace(1.5)),

        LabeledField(
          label: 'Password'.tr(),
          obscureText: widget.obscureText,
          controller: widget.passwordController,
          keyboardType: TextInputType.visiblePassword,
          validator:
              (value) =>
                  value == null || value.isEmpty ? 'PasswordisRequired'.tr() : null,
          suffix: IconButton(
            iconSize: 24,
            splashRadius: 24,
            color: utilities.theme.iconTheme.color?.withOpacity(0.7),
            icon: Icon(
              widget.obscureText
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
            ),
            onPressed: () {
              setState(() {
                widget.obscureText = !widget.obscureText;
              });
            },
          ),
        ).animate().fadeIn(delay: 300.ms),

        SizedBox(height: utilities.vSpace(0.5)),
      ],
    );
  }
}
