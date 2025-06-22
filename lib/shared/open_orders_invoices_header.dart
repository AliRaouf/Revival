import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Widget openOrdersInvoicesHeader(BuildContext context, String title) {
  return AppBar(
    automaticallyImplyLeading: false,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      tooltip: 'Back',
      onPressed: () => Navigator.pop(context),
    ),
    title: Text(title),
    actions: [
      // IconButton(
      //   icon: const Icon(Icons.person_outline),
      //   tooltip: 'Profile',
      //   onPressed: () {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(
      //         content: Text('Profile button tapped!'),
      //         behavior: SnackBarBehavior.floating,
      //       ),
      //     );
      //   },
      // ),
    ],
  );
}
