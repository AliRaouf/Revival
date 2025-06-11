import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Widget openOrdersSearch(
  BuildContext context,
  TextEditingController searchController,
  String searchQuery,
) {
  final theme = Theme.of(context);
  final iconColor = theme.iconTheme.color?.withOpacity(0.6);

  return Padding(
    padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
    child: TextField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: 'Search by Name or Order Code',
        prefixIcon: Icon(Icons.search, color: iconColor),
        suffixIcon:
            searchQuery.isNotEmpty
                ? IconButton(
                  icon: Icon(Icons.clear, color: iconColor),
                  tooltip: 'Clear Search',
                  onPressed: () {
                    searchController.clear();
                  },
                )
                : null,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 16.0,
        ),
      ).applyDefaults(theme.inputDecorationTheme),
      style: theme.textTheme.bodyLarge,
    ),
  );
}
