import 'package:flutter/material.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/features/order/data/models/single_order/data.dart';
import 'package:revival/features/order/data/models/single_order/order_line.dart';
import 'package:revival/features/order/presentation/utils/order_utils.dart';
import 'package:revival/features/order/presentation/views/widgets/info_card.dart';
import 'package:revival/features/order/presentation/views/widgets/total_row.dart';
import 'package:easy_localization/easy_localization.dart';

/// Displays the totals section (Discount, VAT, Total) with enhanced styling.
class OrderTotalsCard extends StatelessWidget {
  final Data data;
  const OrderTotalsCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // Calculate totals
    return InfoCard(
      title: 'Order Summary'.tr(),
      titleIcon: Icons.calculate_outlined,
      child: Column(
        children: [
          // Subtotal
          TotalRow(
            label: 'Original Price'.tr(),
            value: '{subtotal} EGP'.tr(
              namedArgs: {
                'subtotal': (data.docTotal! - data.vatSum! + data.discSum!)
                    .toStringAsFixed(2),
              },
            ),
            labelStyle: textTheme.bodyMedium?.copyWith(
              color: mediumTextColor,
              fontWeight: FontWeight.w500,
            ),
            valueStyle: textTheme.bodyMedium?.copyWith(
              color: darkTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),

          // Discount
          if (data.discSum != null && data.discSum! > 0) ...[
            TotalRow(
              label: 'Discount'.tr(),
              value: '{discountPercentage}% ({totalDiscount} EGP)'.tr(
                namedArgs: {
                  'discountPercentage': data.discPrcnt!.toStringAsFixed(1),
                  'totalDiscount': data.discSum!.toStringAsFixed(2),
                },
              ),
              labelStyle: textTheme.bodyMedium?.copyWith(
                color: mediumTextColor,
                fontWeight: FontWeight.w500,
              ),
              valueStyle: textTheme.bodyMedium?.copyWith(
                color: successColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
          ],

          // VAT
          TotalRow(
            label: 'VAT'.tr(),
            value: '{totalVAT} EGP'.tr(
              namedArgs: {'totalVAT': data.vatSum!.toStringAsFixed(2)},
            ),
            labelStyle: textTheme.bodyMedium?.copyWith(
              color: mediumTextColor,
              fontWeight: FontWeight.w500,
            ),
            valueStyle: textTheme.bodyMedium?.copyWith(
              color: darkTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),

          // Divider
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  subtleBorderColor.withOpacity(0.3),
                  subtleBorderColor,
                  subtleBorderColor.withOpacity(0.3),
                ],
              ),
            ),
          ),

          // Total
          TotalRow(
            label: 'Total Amount'.tr(),
            value: '{total} EGP'.tr(
              namedArgs: {'total': data.docTotal?.toStringAsFixed(2) ?? ""},
            ),
            labelStyle: textTheme.titleMedium?.copyWith(
              color: darkTextColor,
              fontWeight: FontWeight.w600,
            ),
            valueStyle: textTheme.titleLarge?.copyWith(
              color: primaryColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
