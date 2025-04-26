import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageIconButton extends StatelessWidget {
  const LanguageIconButton({super.key});
  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Select Language'),
          children:
              context.supportedLocales.map((locale) {
                final isSelected = context.locale == locale;
                return ListTile(
                  title: Text(
                    locale.languageCode == 'en' ? 'English' : 'العربية',
                  ),
                  trailing:
                      isSelected
                          ? const Icon(Icons.check, color: Colors.green)
                          : null,
                  onTap: () {
                    context.setLocale(locale);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.language_outlined, color: Color(0xfff9f9f9)),
      tooltip: 'Change Language',
      onPressed: () {
        _showLanguageDialog(context);
      },
    );
  }
}
