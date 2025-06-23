import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:revival/features/order/data/models/all_orders/value.dart';

import 'package:revival/features/order/presentation/cubit/single_order/single_order_cubit.dart';

class OrderInvoiceSummaryCard extends StatelessWidget {
  final Value? order;

  const OrderInvoiceSummaryCard({super.key, this.order});

  @override
  Widget build(BuildContext context) {
    final dateTime = DateTime.parse(order?.docDate ?? "");
    final formattedDate = DateFormat('dd/MM/yyyy').format(dateTime).toLocale();
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final listTileTheme = theme.listTileTheme;

    return Card(
      child: InkWell(
        splashColor: theme.splashColor,
        highlightColor: theme.highlightColor,
        onTap: () {
          context.read<SingleOrderCubit>().getSingleOrder(
            order?.docEntry.toString() ?? "",
          );
          context.go('/order/single_order');
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
            order?.docNum.toString() ?? "",

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
              'Code: ${order?.cardCode ?? ""} / Date: ${formattedDate}',

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
