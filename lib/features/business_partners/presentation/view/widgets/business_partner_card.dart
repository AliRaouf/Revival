import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:revival/features/business_partners/data/models/business_partner/datum.dart';
import 'package:revival/shared/utils.dart';

class BusinessPartnerCard extends StatelessWidget {
  final Datum partner;
  final NumberFormat currencyFormatter;
  final Color Function(double) getBalanceColor;
  const BusinessPartnerCard({
    super.key,
    required this.partner,
    required this.currencyFormatter,
    required this.getBalanceColor,
  });

  @override
  Widget build(BuildContext context) {
    final utilities = Utilities(context);
    final balance = partner.currentBalance ?? 0;
    final balanceColor = getBalanceColor(balance);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      decoration: BoxDecoration(
        color: utilities.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: utilities.colorScheme.primary.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            // Professional Avatar
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    utilities.colorScheme.primary.withOpacity(0.1),
                    utilities.colorScheme.primary.withOpacity(0.2),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: utilities.colorScheme.primary.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.business_center_rounded,
                size: 24,
                color: utilities.colorScheme.primary,
              ),
            ),

            const SizedBox(width: 16),

            // Content Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Partner Name - Full Width
                  Text(
                    partner.cardName ?? 'Unknown Partner',
                    style: utilities.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: utilities.colorScheme.onSurface,
                      letterSpacing: -0.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 12),

                  // Bottom Row with Code, Location, and Balance
                  Row(
                    children: [
                      // Code and Location Column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Partner Code
                            Text(
                              partner.cardCode ?? 'No Code',
                              style: utilities.textTheme.bodySmall?.copyWith(
                                color: utilities.colorScheme.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),

                            const SizedBox(height: 6),

                            // Location
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_rounded,
                                  size: 14,
                                  color: utilities.textTheme.bodySmall?.color
                                      ?.withOpacity(0.6),
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    partner.address ??
                                        partner.cardName ??
                                        'No Address',
                                    style: utilities.textTheme.bodySmall
                                        ?.copyWith(
                                          color: utilities
                                              .textTheme
                                              .bodySmall
                                              ?.color
                                              ?.withOpacity(0.7),
                                          fontWeight: FontWeight.w500,
                                        ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Balance
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Balance',
                            style: utilities.textTheme.bodySmall?.copyWith(
                              color: utilities.textTheme.bodySmall?.color
                                  ?.withOpacity(0.6),
                              fontWeight: FontWeight.w500,
                              fontSize: 11,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            currencyFormatter.format(balance),
                            style: utilities.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: balanceColor,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
