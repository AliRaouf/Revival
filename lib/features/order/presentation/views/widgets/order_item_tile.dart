import 'package:flutter/material.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/features/order/data/models/single_order/order_line.dart';

/// Displays a single item in the order list with enhanced professional styling.
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

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: subtleBorderColor.withOpacity(0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Item number with professional styling
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                (item.lineNum! + 1).toString(),
                style: textTheme.labelMedium?.copyWith(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Item details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.itemName ?? "No Name",
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: darkTextColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),

                // Item code with icon
                Row(
                  children: [
                    Icon(
                      Icons.inventory_2_outlined,
                      size: 14,
                      color: mediumTextColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Code: ${item.itemCode ?? "-"}',
                      style: textTheme.bodySmall?.copyWith(
                        color: mediumTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // Price and discount information
                Row(
                  children: [
                    Icon(
                      Icons.attach_money_outlined,
                      size: 14,
                      color: mediumTextColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Price: ${price.toStringAsFixed(2)} EGP',
                      style: textTheme.bodySmall?.copyWith(
                        color: mediumTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (discount > 0) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: successColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${discount.toStringAsFixed(1)}% OFF',
                          style: textTheme.labelSmall?.copyWith(
                            color: successColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // Quantity and total
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Quantity with badge styling
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: secondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'x ${quantity.toStringAsFixed(quantity.truncateToDouble() == quantity ? 0 : 2)}',
                  style: textTheme.bodySmall?.copyWith(
                    color: secondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Total amount
              Text(
                '${itemTotal.toStringAsFixed(2)} EGP',
                style: textTheme.titleMedium?.copyWith(
                  color: primaryColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
