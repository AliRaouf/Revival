import 'package:flutter/material.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/features/order/data/models/single_order/order_line.dart';
import 'package:revival/features/order/presentation/views/widgets/info_card.dart';
import 'package:revival/features/order/presentation/views/widgets/order_item_tile.dart';
import 'package:easy_localization/easy_localization.dart';

/// Displays the list of items in the order with enhanced styling.
class OrderItemsList extends StatelessWidget {
  final List<OrderLine> orderLines;
  const OrderItemsList({super.key, required this.orderLines});

  @override
  Widget build(BuildContext context) {
    if (orderLines.isEmpty) {
      return InfoCard(
        title: 'Order Items'.tr(),
        titleIcon: Icons.inventory_2_outlined,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: Column(
              children: [
                Icon(
                  Icons.inventory_2_outlined,
                  size: 48,
                  color: mediumTextColor.withOpacity(0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  'No items in this order',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: mediumTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Items will appear here once added',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: mediumTextColor.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return InfoCard(
      title: null,
      titleIcon: null,
      // Custom title row with icon, title, and counter badge
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.inventory_2_outlined, size: 20, color: primaryColor),
              const SizedBox(width: 8),
              Text(
                'Order Items'.tr(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 12),
              Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  '{count} {itemWord}'.tr(
                    namedArgs: {
                      'count': orderLines.length.toString(),
                      'itemWord':
                          orderLines.length == 1 ? 'item'.tr() : 'items'.tr(),
                    },
                  ),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Items list
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: orderLines.length,
            itemBuilder: (context, index) {
              final item = orderLines[index];
              return OrderItemTile(item: item);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 16),
          ),
        ],
      ),
    );
  }
}
