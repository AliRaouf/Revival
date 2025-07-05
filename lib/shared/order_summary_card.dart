import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/features/order/data/models/all_orders/value.dart';
import 'package:revival/features/order/presentation/cubit/single_order/single_order_cubit.dart';

class OrderInvoiceSummaryCard extends StatelessWidget {
  final Value? order;

  const OrderInvoiceSummaryCard({super.key, this.order});

  @override
  Widget build(BuildContext context) {
    final dateTime = DateTime.parse(order?.docDate ?? "");
    final formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kCardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: shadowColor.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kCardBorderRadius),
          side: BorderSide(color: subtleBorderColor.withOpacity(0.3), width: 1),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(kCardBorderRadius),
          splashColor: primaryColor.withOpacity(0.1),
          highlightColor: primaryColor.withOpacity(0.05),
          onTap: () {
            context.read<SingleOrderCubit>().getSingleOrder(
              order?.docEntry.toString() ?? "",
            );
            context.go('/order/single_order');
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Order icon with enhanced styling
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.receipt_long,
                    color: primaryColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),

                // Order details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Order number
                      Text(
                        'Order #${order?.docNum.toString() ?? ""}',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: primaryColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),

                      // Customer code and date
                      Row(
                        children: [
                          Icon(
                            Icons.person_outline,
                            size: 14,
                            color: mediumTextColor,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              order?.cardCode ?? "",
                              style: textTheme.bodySmall?.copyWith(
                                color: mediumTextColor,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),

                      // Date with icon
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 14,
                            color: mediumTextColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            formattedDate,
                            style: textTheme.bodySmall?.copyWith(
                              color: mediumTextColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // Chevron icon
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.chevron_right,
                    color: mediumTextColor.withOpacity(0.7),
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
