import 'package:flutter/material.dart';
import 'package:revival/features/order/data/models/single_order/order_line.dart';
import 'package:revival/features/order/presentation/utils/order_utils.dart';
import 'package:revival/features/order/presentation/views/single_order.dart';
import 'package:revival/features/order/presentation/views/widgets/info_card.dart';
import 'package:revival/features/order/presentation/views/widgets/total_row.dart';

/// Displays the totals section (Discount, VAT, Total).
class OrderTotalsCard extends StatelessWidget {
  final List<OrderLine> orderLines; // Replace with your OrderLine model
  const OrderTotalsCard({super.key, required this.orderLines});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final totalValue = OrderUtils().totalPrice(orderLines).toStringAsFixed(2);
    final primaryColor = Theme.of(context).colorScheme.primary;

    return InfoCard(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          TotalRow(label: 'Discount', value: '0%'),
          const SizedBox(height: 12),
          TotalRow(label: 'VAT', value: '0'),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            // The Divider now uses the app's dividerTheme
            child: Divider(),
          ),
          TotalRow(
            label: 'Total',
            value: totalValue,
            valueStyle: textTheme.headlineSmall?.copyWith(color: primaryColor),
          ),
        ],
      ),
    );
  }
}
