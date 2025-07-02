import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/shared/utils.dart';

// ignore: must_be_immutable
class BusinessPartnerAppbar extends StatefulWidget
    implements PreferredSizeWidget {
  const BusinessPartnerAppbar({
    super.key,
  });

  @override
  State<BusinessPartnerAppbar> createState() => _BusinessPartnerAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _BusinessPartnerAppbarState extends State<BusinessPartnerAppbar> {
  @override
  Widget build(BuildContext context) {
    Utilities utilities = Utilities(context);
    return AppBar(
      title: Text("Business Partners")
          .animate()
          .fadeIn(duration: 400.ms)
          .slideY(begin: -0.2, duration: 300.ms, curve: Curves.easeOut),
      backgroundColor: utilities.colorScheme.primary,
      foregroundColor: utilities.colorScheme.onPrimary,
      elevation: 2.0,
    );
  }
}
