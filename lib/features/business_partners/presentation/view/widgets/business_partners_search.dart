import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

Widget businessPartnersSearch(
  BuildContext context,
  TextEditingController searchController,
  String searchQuery,
) {
  final theme = Theme.of(context);
  final iconColor = theme.iconTheme.color?.withOpacity(0.6);
  final isSearching = searchQuery.isNotEmpty;

  return Padding(
    padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
    child: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search by Name or Code'.tr(),
            prefixIcon: Icon(Icons.search, color: iconColor),
            suffixIcon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder:
                  (child, animation) => FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.3, 0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  ),
              child:
                  isSearching
                      ? IconButton(
                        key: const ValueKey('clear'),
                        icon: Icon(Icons.clear, color: iconColor),
                        tooltip: 'Clear Search',
                        onPressed: () {
                          searchController.clear();
                        },
                      )
                      : const SizedBox.shrink(key: ValueKey('empty')),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16.0,
            ),
          ).applyDefaults(theme.inputDecorationTheme),
          style: theme.textTheme.bodyLarge,
        )
        .animate()
        .fadeIn(duration: 400.ms)
        .slideY(begin: 0.2, duration: 350.ms, curve: Curves.easeOut),
  );
}
