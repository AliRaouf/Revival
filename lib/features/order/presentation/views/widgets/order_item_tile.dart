import 'package:flutter/material.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/features/order/data/models/single_order/order_line.dart';

/// Displays a single item in the order list.
class OrderItemTile extends StatelessWidget {
  final OrderLine item;
  const OrderItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final price = item.price ?? 0.0;
    final quantity = item.quantity ?? 0.0;
    final discount = item.discPrcnt ?? 0.0;
    final itemTotal = (price * quantity) - (discount * quantity);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 3.0),
          // Using a theme color for the icon
          child: Text((item.lineNum! + 1).toString()),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.itemName ?? "No Name", style: textTheme.titleMedium),
              const SizedBox(height: 5),
              Text('Code: ${item.itemCode ?? "-"}', style: textTheme.bodySmall),
              const SizedBox(height: 5),
              Text(
                'Price: ${price.toStringAsFixed(2)}${discount > 0 ? " / Disc: ${discount.toStringAsFixed(2)} " : ""} EGP',
                style: textTheme.bodySmall?.copyWith(color: mediumTextColor),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'x ${quantity.toStringAsFixed(quantity.truncateToDouble() == quantity ? 0 : 2)}',
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 5),
            Text(
              '${itemTotal.toStringAsFixed(2)} EGP',
              style: textTheme.titleMedium,
            ),
          ],
        ),
      ],
    );
  }
}
