import 'package:flutter/material.dart';
import 'package:revival/features/order/presentation/views/widgets/order_item_tile.dart';

/// Displays the list of items in the order.
class OrderItemsList extends StatelessWidget {
  final List<dynamic> orderLines; // Replace with your OrderLine model
  const OrderItemsList({super.key, required this.orderLines});

  @override
  Widget build(BuildContext context) {
    if (orderLines.isEmpty) {
      return const Center(child: Text('No items found'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ITEMS', style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 12),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: orderLines.length,
          itemBuilder: (context, index) {
            final item = orderLines[index];
            return OrderItemTile(item: item);
          },
          // DividerTheme from appTheme is used here automatically
          separatorBuilder: (context, index) => const Divider(height: 24),
        ),
      ],
    );
  }
}
