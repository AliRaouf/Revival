import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:revival/shared/utils.dart';

class SavePartnerButton extends StatelessWidget {
  final void Function()? saveForm;
  const SavePartnerButton({super.key, required this.saveForm});

  @override
  Widget build(BuildContext context) {
    final utilities = Utilities(context);
    return Center(
      child: ElevatedButton.icon(
        icon: const Icon(Icons.save_alt_outlined),
        label: Text("Save Partner"),
        style: ElevatedButton.styleFrom(
          backgroundColor: utilities.colorScheme.secondary,
          foregroundColor: utilities.colorScheme.onSecondary,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
          textStyle: utilities.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 2.0,
        ),
        onPressed: saveForm,
      ),
    );
  }
}
