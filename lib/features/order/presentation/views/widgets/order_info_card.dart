import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:revival/features/order/data/models/single_order/single_order.dart';
import 'package:revival/features/order/presentation/views/single_order.dart';
import 'package:revival/features/order/presentation/views/widgets/info_card.dart';
import 'package:revival/features/order/presentation/views/widgets/info_row.dart';

/// Displays the main order details card.
class OrderInfoCard extends StatelessWidget {
  final SingleOrder orderData;
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
              DateTime.parse(
                orderData.data?.docDate ?? DateTime.now().toIso8601String(),
              ),
            )),
          ),
          const SizedBox(height: 18),
          InfoRow(
            label: 'Due Date',
            value: DateFormat.yMMMd().format(
              DateTime.parse(
                orderData.data?.docDueDate ?? DateTime.now().toIso8601String(),
              ),
            ),
          ),
          const SizedBox(height: 18),
          InfoRow(
            label: 'Reference Number',
            value: orderData.data?.docNum.toString() ?? '-',
          ),
          const SizedBox(height: 18),
          InfoRow(label: 'Phone', value: orderData.data?.phone1 as String),
        ],
      ),
    );
  }
}
