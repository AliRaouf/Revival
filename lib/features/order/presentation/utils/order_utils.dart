
import 'package:flutter/material.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/features/order/domain/entity/order.dart';
import 'package:revival/features/order/presentation/views/widgets/summary_row.dart';
import 'package:revival/shared/utils.dart';

class OrderUtils {
final List<OrderInfo> allOrders = List.generate(
    20,
    (index) => OrderInfo(
      id: 'ORDER_${100 + index}',
      invoice: '10000$index',
      order: '${500 + index}',
      orderCode: 'RC${20210 + index}',
      quote: '100$index',
      customerName:
          index % 3 == 0
              ? 'Ahmed Khaled Co.'
              : index % 3 == 1
              ? 'Fatima Hassan Trading'
              : 'Global Solutions Ltd.',
    ),
  );













  Future<void> showSuccessDialog(BuildContext context) async {
    Utilities utilities = Utilities(context);

    const String subtotal = '100.00 GBP';
    const String discount = '-10.00 GBP (10%)';
    const String vat = '+15.00 GBP (15%)';
    const String grandTotal = '105.00 GBP';

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 16.0),
          titlePadding: const EdgeInsets.only(top: 24.0),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.check_circle, color: successColor, size: 50.0),
              const SizedBox(height: 16.0),

              Text(
                "Success",
                style: utilities.textTheme.titleMedium?.copyWith(
                  color: successColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),

              Text(
                'Thank you for your request.\nOrder submitted.',
                textAlign: TextAlign.center,
                style: utilities.textTheme.bodyMedium,
              ),
              const SizedBox(height: 20.0),

              Text(
                'Invoice Summary:',
                style: utilities.textTheme.titleSmall?.copyWith(color: mediumTextColor),
              ),
              const SizedBox(height: 8.0),

              buildSummaryRow(context, 'Subtotal:', subtotal),
              buildSummaryRow(context, 'Discount:', discount),
              buildSummaryRow(context, 'VAT:', vat),
              const Divider(height: 20),
              buildSummaryRow(
                context,
                'Grand Total:',
                grandTotal,
                isBold: true,
              ),
              const SizedBox(height: 24.0),
            ],
          ),

          actionsPadding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.chat_bubble_outline, size: 18),
                    label: const Text('WhatsApp'),

                    style: kElevatedButtonSuccessStyle.copyWith(
                      backgroundColor: WidgetStateProperty.all(whatsappColor),
                    ),
                    onPressed: () {
                      print('WhatsApp UI Button Tapped');
                      ScaffoldMessenger.of(dialogContext).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'WhatsApp integration not implemented.',
                          ),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                    },
                    child: const Text('OK'),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
