import 'package:flutter/material.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/features/order/data/models/single_order/single_order.dart';
import 'package:revival/features/order/presentation/views/widgets/contact_icon_button.dart';
import 'package:revival/features/order/presentation/views/widgets/info_card.dart';
import 'package:revival/features/order/presentation/views/widgets/info_row.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// Displays the contact information and action buttons.
class ContactInfoCard extends StatelessWidget {
  final SingleOrder orderData;
  const ContactInfoCard({super.key, required this.orderData});

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoRow(
            label: 'Sales Person',
            value: orderData.data?.salesEmployeeName ?? '',
            isValueBold: true,
          ),
          const SizedBox(height: 18),
          InfoRow(
            label: 'Phone Number',
            value: orderData.data?.salesEmployeeMobile ?? '',
          ),
          const SizedBox(height: 20),
          Text(
            'CONTACT ACTIONS',
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: mediumTextColor),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ContactIconButton(
                icon: Icons.phone_outlined,
                tooltip: 'Call Contact',
                onTap:
                    () => launchUrlString(
                      "tel://${orderData.data?.phone1 ?? ''}",
                    ),
              ),
              const SizedBox(width: 16),
              ContactIconButton(
                icon: Icons.message_outlined,
                tooltip: 'Message Contact',
                onTap:
                    () => launchUrlString(
                      "sms://${orderData.data?.phone1 ?? ''}",
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
