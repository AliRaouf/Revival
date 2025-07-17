import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:revival/features/order/data/models/single_order/single_order.dart';
import 'package:revival/features/order/presentation/views/widgets/info_card.dart';
import 'package:revival/features/order/presentation/views/widgets/info_row.dart';

/// Displays the main order details card.
class OrderInfoCard extends StatelessWidget {
  final SingleOrder orderData;
  const OrderInfoCard({super.key, required this.orderData});

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      title: 'Order Information'.tr(),
      titleIcon: Icons.receipt_long,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoRow(
            label: 'Customer'.tr(),
            value: orderData.data?.cardName?.toString() ?? "-",
            isValueBold: true,
          ),
          const SizedBox(height: 20),
          InfoRow(
            label: 'Document Date'.tr(),
            value: (DateFormat.yMMMd().format(
              DateTime.parse(
                orderData.data?.docDate ?? DateTime.now().toIso8601String(),
              ),
            )),
          ),
          const SizedBox(height: 20),
          InfoRow(
            label: 'Due Date'.tr(),
            value: DateFormat.yMMMd().format(
              DateTime.parse(
                orderData.data?.docDueDate ?? DateTime.now().toIso8601String(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          InfoRow(
            label: 'Reference Number'.tr(),
            value: orderData.data?.docEntry?.toString() ?? '-',
          ),
          const SizedBox(height: 20),
          InfoRow(
            label: 'Phone'.tr(),
            value: "0${orderData.data?.phone1?.toString() ?? "-"}" ,
          ),
        ],
      ),
    );
  }
}
