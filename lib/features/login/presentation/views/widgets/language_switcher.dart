import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:revival/shared/utils.dart'; // Make sure easy_localization is imported

class LanguageSwitcher extends StatefulWidget {
  const LanguageSwitcher({super.key});

  @override
  State<LanguageSwitcher> createState() => _LanguageSwitcherState();
}

class _LanguageSwitcherState extends State<LanguageSwitcher>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
      lowerBound: 0.95,
      upperBound: 1.0,
      value: 1.0,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Utilities utilities = Utilities(context);
    final currentLocale = context.locale;
    final List<Locale> supportedLocales = [
      const Locale('en', 'US'),
      const Locale('ar', 'EG'),
    ];
    final List<String> languageLabels = ['English', 'العربية'];

    return Material(
      color: Colors.transparent,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              decoration: BoxDecoration(
                color: utilities.colorScheme.primary.withOpacity(0.07),
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(supportedLocales.length, (index) {
                  final isSelected =
                      currentLocale.languageCode ==
                      supportedLocales[index].languageCode;
                  return GestureDetector(
                    onTap: () async {
                      if (!isSelected) {
                        _controller.reverse().then((_) {
                          _controller.forward();
                        });
                        await context.setLocale(supportedLocales[index]);
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? utilities.colorScheme.primary
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow:
                            isSelected
                                ? [
                                  BoxShadow(
                                    color: utilities.colorScheme.primary
                                        .withOpacity(0.10),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                                : [],
                      ),
                      child: Text(
                        languageLabels[index],
                        style: TextStyle(
                          color:
                              isSelected
                                  ? utilities.colorScheme.onPrimary
                                  : utilities.colorScheme.primary,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          );
        },
      ),
    );
  }
}
