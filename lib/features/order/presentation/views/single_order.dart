import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/features/order/data/models/single_order/order_line.dart';
import 'package:revival/features/order/data/models/single_order/single_order.dart';
import 'package:revival/features/order/presentation/utils/order_utils.dart';
import 'package:revival/features/order/presentation/views/widgets/copy_to_invoice_button.dart';

class SingleOrderScreen extends StatelessWidget {
  // final String orderId;

  const SingleOrderScreen({
    super.key,
    // required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    final orderData = OrderUtils().order;
    if (orderData.data == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Order Details')),
        body: const Center(child: Text('Order not found.')),
      );
    }

    return Scaffold(
      // The Scaffold's background color is now handled by the appTheme.
      appBar: AppBar(
        // The AppBar's style is now handled by appTheme.appBarTheme.
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Order ${orderData.data?.salesEmployeeMobile ?? ""}'),
            const SizedBox(height: 3),
            Text(
              orderData.data?.salesEmployeeName ?? "No Customer Name",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
            ),
          ],
        ),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Replaced _buildSectionCard with a dedicated widget
              OrderInfoCard(orderData: orderData),
              const SizedBox(height: 24),

              // Replaced _buildSectionCard for contact info
              ContactInfoCard(orderData: orderData),
              const SizedBox(height: 24),

              // Replaced _buildWowTextButton with a standard ElevatedButton using the theme
              ElevatedButton(
                onPressed: () => print('Custom Fields button tapped'),
                child: const Text('Custom Fields'),
              ),
              const SizedBox(height: 24),

              // Replaced item list with a dedicated widget
              OrderItemsList(orderLines: orderData.data?.orderLines ?? []),
              const SizedBox(height: 24),

              // Replaced totals section with a dedicated widget
              OrderTotalsCard(orderLines: orderData.data?.orderLines ?? []),
              const SizedBox(height: 30),

              CopyToInvoiceCollectButton(type: "Invoice"),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

/// A reusable card widget to display information sections.
/// It uses the app's CardTheme for styling.
class InfoCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const InfoCard({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kCardBorderRadius),
          side: BorderSide(
            color: Theme.of(context).dividerTheme.color!,
            width: 1,
          ),
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(18.0),
          child: child,
        ),
      ),
    );
  }
}

/// A reusable row widget to display a label and a value.
/// It uses text styles from the app's TextTheme.
class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isValueBold;

  const InfoRow({
    super.key,
    required this.label,
    required this.value,
    this.isValueBold = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label.toUpperCase(),
          // Uses labelSmall from the appTheme for labels
          style: textTheme.labelSmall?.copyWith(color: mediumTextColor),
        ),
        const SizedBox(height: 5),
        Text(
          value.isEmpty ? '-' : value,
          // Uses titleMedium for prominent values and bodyMedium for regular ones
          style: (isValueBold ? textTheme.titleMedium : textTheme.bodyMedium)
              ?.copyWith(height: 1.3),
        ),
      ],
    );
  }
}

/// Displays the main order details card.
class OrderInfoCard extends StatelessWidget {
  final dynamic orderData; // Replace 'dynamic' with your actual OrderData model
  const OrderInfoCard({super.key, required this.orderData});

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoRow(
            label: 'Customer',
            value: orderData.data?.salesEmployeeName as String,
            isValueBold: true,
          ),
          const SizedBox(height: 18),
          InfoRow(
            label: 'Document Date',
            value: (DateFormat.yMMMd().format(
              DateTime.parse(orderData.data.docDate!),
            )),
          ),
          const SizedBox(height: 18),
          InfoRow(
            label: 'Due Date',
            value: DateFormat.yMMMd().format(
              DateTime.parse(orderData.data.docDueDate!),
            ),
          ),
          const SizedBox(height: 18),
          InfoRow(
            label: 'Reference Number',
            value: orderData.data.docEntry.toString(),
          ),
          const SizedBox(height: 18),
          InfoRow(label: 'Title', value: orderData.data.cardCode ?? '-'),
        ],
      ),
    );
  }
}

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
            label: 'Contact Person',
            value: orderData.data?.salesEmployeeName ?? '',
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
                onTap: () => print('Phone button tapped'),
              ),
              const SizedBox(width: 16),
              ContactIconButton(
                icon: Icons.email_outlined,
                tooltip: 'Email Contact',
                onTap: () => print('Contact email button tapped'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// A circular icon button for contact actions.
class ContactIconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const ContactIconButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Overrides the theme for a circular shape but uses theme colors.
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(10),
        minimumSize: const Size(40, 40),
        // Uses the primary color from the theme's colorScheme
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      child: Tooltip(message: tooltip, child: Icon(icon, size: 20)),
    );
  }
}

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

/// A simple row for the totals card.
class TotalRow extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? valueStyle;

  const TotalRow({
    super.key,
    required this.label,
    required this.value,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: textTheme.bodyLarge),
        Text(value, style: valueStyle ?? textTheme.titleMedium),
      ],
    );
  }
}
