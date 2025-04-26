import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:revival/features/business_partners/domain/entities/business_partner.dart';
import 'package:revival/shared/utils.dart';

class BusinessPartnerExpandableCard extends StatelessWidget {
  final BusinessPartner partner;
  final NumberFormat currencyFormatter;
  final Color Function(double) getBalanceColor;
  final bool isExpanded;
  final VoidCallback onTap;
  const BusinessPartnerExpandableCard({
    super.key,
    required this.partner,
    required this.currencyFormatter,
    required this.getBalanceColor,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final utilities = Utilities(context); // Access the utilities
    final balanceColor = getBalanceColor(partner.balance);

    return Card(
      elevation: isExpanded ? 4.0 : 1.5,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      // Use utilities's surface color for card background
      color: utilities.colorScheme.surface,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        // Use utilities's primary color for splash/highlight effects
        splashColor: utilities.colorScheme.primary.withOpacity(0.1),
        highlightColor: utilities.colorScheme.primary.withOpacity(0.05),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20,
                    // Use utilities's primary color with opacity for avatar background
                    backgroundColor: utilities.colorScheme.primary.withOpacity(
                      0.1,
                    ),
                    child: Icon(
                      Icons.business_center_outlined,
                      size: 20,
                      // Use utilities's primary color for avatar icon
                      color: utilities.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          partner.name,
                          style: utilities.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            // Use utilities's onSurface color for text
                            color: utilities.colorScheme.onSurface,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          partner.code,
                          style: utilities.textTheme.bodySmall?.copyWith(
                            color: utilities.textTheme.bodySmall?.color
                                ?.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        currencyFormatter.format(partner.balance),
                        style: utilities.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: balanceColor,
                        ),
                      ),
                      Text(
                        // Localize label
                        'Balance',
                        style: utilities.textTheme.bodySmall?.copyWith(
                          // Use a slightly less prominent color for label
                          color: utilities.textTheme.bodySmall?.color
                              ?.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Icon(
                        isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: utilities.textTheme.bodySmall?.color
                            ?.withOpacity(0.6),
                        size: 24,
                      ),
                    ],
                  ),
                ],
              ),

              AnimatedSize(
                duration: 300.ms,
                curve: Curves.easeInOutCubic,
                alignment: Alignment.topCenter,
                child: Visibility(
                  visible: isExpanded,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Use utilities's divider color
                        Divider(
                          height: 1,
                          thickness: 0.5,
                          color: utilities.theme.dividerColor,
                        ),
                        const SizedBox(height: 12),
                        // Pass textutilities to _buildDetailRow
                        _buildDetailRow(
                          Icons.location_on_outlined,
                          // Localize label
                          "Location",
                          partner.location,
                          utilities.colorScheme.primary,
                          context, // Pass primary color for icon
                        ),
                        if (partner.contactPerson != null)
                          _buildDetailRow(
                            Icons.person_outline,
                            // Localize label
                            "Contact",
                            partner.contactPerson!,
                            utilities.colorScheme.primary,
                            context, // Pass primary color for icon
                          ),
                        if (partner.phone != null)
                          _buildDetailRow(
                            Icons.phone_outlined,
                            // Localize label
                            "Phone",
                            partner.phone!,
                            utilities.colorScheme.primary,
                            context,
                          ),
                        const SizedBox(height: 16),
                        Center(
                          child: ElevatedButton.icon(
                                icon: const Icon(
                                  Icons.receipt_long_outlined,
                                  size: 18,
                                ),
                                // Localize button label
                                label: Text('Create Invoice'),
                                style: ElevatedButton.styleFrom(
                                  // Use utilities's accent color (secondary) for button background
                                  backgroundColor:
                                      utilities.colorScheme.secondary,
                                  // Use utilities's onSecondary color for button text/icon
                                  foregroundColor:
                                      utilities.colorScheme.onSecondary,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  textStyle: utilities.textTheme.labelLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  // Localize snackbar message
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Create Invoice for ${partner.name} (${partner.code})'
                                            ,
                                      ),
                                    ),
                                  );
                                },
                              )
                              .animate()
                              .fadeIn(delay: 150.ms)
                              .scaleXY(begin: 0.8, curve: Curves.elasticOut),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    IconData icon,
    String label,
    String value,
    Color iconColor,
    BuildContext context,
  ) {
    final utilities = Utilities(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: iconColor.withOpacity(0.8)),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: utilities.textTheme.bodySmall?.copyWith(
              color: utilities.textTheme.bodySmall?.color?.withOpacity(0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: utilities.textTheme.bodyMedium?.copyWith(
                color: utilities.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
