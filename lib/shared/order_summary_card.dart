import 'package:flutter/material.dart';
import 'package:revival/features/ar_invoice/domain/entity/invoice.dart';
import 'package:revival/features/ar_invoice/presentation/views/single_invoice.dart';
import 'package:revival/features/order/domain/entity/order.dart';
import 'package:revival/features/order/presentation/views/single_order.dart';

class OrderInvoiceSummaryCard extends StatelessWidget {
  final OrderInfo? order;
  final Invoice? invoice;

  const OrderInvoiceSummaryCard({
    super.key, this.order, this.invoice,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final listTileTheme = theme.listTileTheme;

    return Card(
      child: InkWell(
        splashColor: theme.splashColor,
        highlightColor: theme.highlightColor,
        onTap: () {
            if (order != null) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => SingleOrderScreen(orderId: order!.id),
    ),
  );
}else{
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => SingleInvoiceScreen(invoiceId: invoice!.id),
    ),
  );
}
          },
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: colorScheme.primary.withOpacity(0.1),
            child: Icon(
              Icons.receipt_long,
              color: colorScheme.primary,
              size: 24,
            ),
          ),
          title: Text(
            order?.customerName??invoice!.customerName,

            style:
                listTileTheme.titleTextStyle?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.primary,
                ) ??
                textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.primary,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              'Code: ${order?.orderCode??invoice!.orderCode} / Order: ${order?.order??invoice!.order}',

              style: listTileTheme.subtitleTextStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: listTileTheme.iconColor?.withOpacity(0.8),
            size: 28,
          ),
        ),
      ),
    );
  }
}
