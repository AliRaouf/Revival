import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:revival/shared/utils.dart'; // Make sure easy_localization is imported

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
final Utilities utilities = Utilities(context);
    final currentLocale = context.locale;

    final List<Locale> supportedLocales = [
      const Locale('en', 'US'), // English
      const Locale('ar', 'EG'), // Arabic
    ];

    List<bool> isSelected =
        supportedLocales.map((locale) {
          return currentLocale.languageCode == locale.languageCode;
        }).toList();
    if (isSelected.where((e) => e).length != 1) {
      isSelected = List.generate(
        supportedLocales.length,
        (index) => index == 0,
      );
    }

    return ToggleButtons(
      isSelected: isSelected,
      onPressed: (int index) {
        if (!isSelected[index]) {
          context.setLocale(supportedLocales[index]);
        }
      },
      // Styling
      color: utilities.colorScheme.onSurface.withOpacity(
        0.6,
      ), // Color for unselected text/icon
      selectedColor: utilities.colorScheme.onPrimary,
      fillColor: utilities.colorScheme.primary,
      splashColor: utilities.colorScheme.primary.withOpacity(0.12),
      highlightColor: utilities.colorScheme.primary.withOpacity(0.1),
      borderColor: utilities.colorScheme.primary.withOpacity(0.5),
      selectedBorderColor: utilities.colorScheme.primary,
      borderRadius: BorderRadius.circular(8.0),
      constraints: const BoxConstraints(
        minHeight: 36.0,
        minWidth: 60.0,
      ),
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('English'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 8.0),
          child: Text('العربية'),
        ),
      ],
    );
  }
}
