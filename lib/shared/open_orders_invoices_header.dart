
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget openOrdersInvoicesHeader(BuildContext context, String title) {
  return AppBar(
    automaticallyImplyLeading: false,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      tooltip: 'Back',
      onPressed: () => context.push("/dashboard"),
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
