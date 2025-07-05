import 'package:flutter/material.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/features/order/data/models/single_order/order_line.dart';
import 'package:revival/features/order/presentation/utils/order_utils.dart';
import 'package:revival/features/order/presentation/views/widgets/info_card.dart';
import 'package:revival/features/order/presentation/views/widgets/total_row.dart';

/// Displays the totals section (Discount, VAT, Total) with enhanced styling.
class OrderTotalsCard extends StatelessWidget {
  final List<OrderLine> orderLines;
  const OrderTotalsCard({super.key, required this.orderLines});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // Calculate totals
    double subtotal = 0;
    double totalDiscount = 0;
    double totalVAT = 0;

    for (final line in orderLines) {
      final price = line.price ?? 0.0;
      final quantity = line.quantity ?? 0.0;
      final discount = line.discPrcnt ?? 0.0;

      final lineSubtotal = price * quantity;
      final lineDiscount = (lineSubtotal * discount) / 100;

      subtotal += lineSubtotal;
      totalDiscount += lineDiscount;
    }

    // Assume 15% VAT (you can make this configurable)
    totalVAT = (subtotal - totalDiscount) * 0.15;
    final total = subtotal - totalDiscount + totalVAT;

    final discountPercentage =
        subtotal > 0 ? (totalDiscount / subtotal) * 100 : 0;

    return InfoCard(
      title: 'Order Summary',
      titleIcon: Icons.calculate_outlined,
      child: Column(
        children: [
          // Subtotal
          TotalRow(
            label: 'Subtotal',
            value: '${subtotal.toStringAsFixed(2)} EGP',
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
          if (totalDiscount > 0) ...[
            TotalRow(
              label: 'Discount',
              value:
                  '${discountPercentage.toStringAsFixed(1)}% (${totalDiscount.toStringAsFixed(2)} EGP)',
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
            label: 'VAT (15%)',
            value: '${totalVAT.toStringAsFixed(2)} EGP',
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
            label: 'Total Amount',
            value: '${total.toStringAsFixed(2)} EGP',
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
