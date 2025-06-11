import 'package:flutter/material.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/features/order/data/models/all_orders/all_orders.dart';
import 'package:revival/features/order/data/models/single_order/order_line.dart';
import 'package:revival/features/order/data/models/single_order/single_order.dart';
import 'package:revival/features/order/presentation/views/widgets/summary_row.dart';
import 'package:revival/shared/utils.dart';

class OrderUtils {
    SingleOrder order = SingleOrder.fromJson({
    "success": true,
    "statusCode": 200,
    "message": "Order details retrieved successfully",
    "data": {
      "docEntry": 6,
      "docNum": 6,
      "canceled": "N",
      "docDate": "2013-02-15",
      "docDueDate": "2013-02-25",
      "cardCode": "C30000",
      "phone1": "0113 6789 4739",
      "slpCode": "2",
      "salesEmployeeName": "Bill Levine",
      "salesEmployeeMobile": "",
      "orderLines": [
        {
          "docEntry": 6,
          "lineNum": 0,
          "itemCode": "C00002",
          "itemName": "Motherboard P4 Turbo - Asus Chipset",
          "itemGroupName": "Items",
          "quantity": 10.000000,
          "price": 187.500000,
          "discPrcnt": 0.000000,
          "lineTotal": 1875.000000,
          "whsCode": "01",
          "uomCode": "Manual",
          "openQty": 0.000000,
          "baseLine": 0,
          "baseEntry": 8,
          "baseType": 23,
        },
        {
          "docEntry": 6,
          "lineNum": 1,
          "itemCode": "C00010",
          "itemName": "Mouse USB",
          "itemGroupName": "Items",
          "quantity": 20.000000,
          "price": 12.500000,
          "discPrcnt": 0.000000,
          "lineTotal": 250.000000,
          "whsCode": "01",
          "uomCode": "Manual",
          "openQty": 0.000000,
          "baseLine": 1,
          "baseEntry": 8,
          "baseType": 23,
        },
        {
          "docEntry": 6,
          "lineNum": 2,
          "itemCode": "C00011",
          "itemName": "Memory DDR RAM 512 MB",
          "itemGroupName": "Items",
          "quantity": 20.000000,
          "price": 25.000000,
          "discPrcnt": 0.000000,
          "lineTotal": 500.000000,
          "whsCode": "01",
          "uomCode": "Manual",
          "openQty": 0.000000,
          "baseLine": 2,
          "baseEntry": 8,
          "baseType": 23,
        },
        {
          "docEntry": 6,
          "lineNum": 3,
          "itemCode": "C00008",
          "itemName": "Monitor 19' TFT",
          "itemGroupName": "Items",
          "quantity": 10.000000,
          "price": 125.000000,
          "discPrcnt": 0.000000,
          "lineTotal": 1250.000000,
          "whsCode": "01",
          "uomCode": "Manual",
          "openQty": 0.000000,
          "baseLine": 3,
          "baseEntry": 8,
          "baseType": 23,
        },
        {
          "docEntry": 6,
          "lineNum": 4,
          "itemCode": "C00009",
          "itemName": "Keyboard Comfort USB",
          "itemGroupName": "Items",
          "quantity": 15.000000,
          "price": 12.500000,
          "discPrcnt": 0.000000,
          "lineTotal": 187.500000,
          "whsCode": "01",
          "uomCode": "Manual",
          "openQty": 0.000000,
          "baseLine": 4,
          "baseEntry": 8,
          "baseType": 23,
        },
      ],
    },
    "timestamp": 1749638531110,
  });
  AllOrders allOrders = AllOrders.fromJson({
    "success": true,
    "statusCode": 200,
    "message": "User open orders retrieved successfully",
    "data": {
      "odata.metadata":
          "https://b1cloud.revival-me.com/b1s/v1/\$metadata#SAPB1.SQLQueryResult",
      "odata.sql":
          "SELECT * FROM \"ORDR\" WHERE \"SlpCode\" = '2' AND \"DocStatus\" = 'O'",
      "value": [
        {
          "DocEntry": 943,
          "DocNum": 943,
          "DocType": "I",
          "DocStatus": "O",
          "DocDate": "20220408",
          "DocDueDate": "20220508",
          "CardCode": "C30000",
          "SlpCode": "2",
          "DocTotal": 1434.000000,
          "DiscPrcnt": 0.000000,
          "DiscSum": 0.000000,
          "VatPercent": 0.000000,
          "VatSum": 239.000000,
          "CANCELED": "N",
        },
        {
          "DocEntry": 1021,
          "DocNum": 1021,
          "DocType": "I",
          "DocStatus": "O",
          "DocDate": "20221122",
          "DocDueDate": "20221222",
          "CardCode": "C30000",
          "SlpCode": "2",
          "DocTotal": 1050.000000,
          "DiscPrcnt": 0.000000,
          "DiscSum": 0.000000,
          "VatPercent": 0.000000,
          "VatSum": 175.000000,
          "CANCELED": "N",
        },
        {
          "DocEntry": 1158,
          "DocNum": 1158,
          "DocType": "I",
          "DocStatus": "O",
          "DocDate": "20230819",
          "DocDueDate": "20230918",
          "CardCode": "C30000",
          "SlpCode": "2",
          "DocTotal": 285.600000,
          "DiscPrcnt": 0.000000,
          "DiscSum": 0.000000,
          "VatPercent": 0.000000,
          "VatSum": 47.600000,
          "CANCELED": "N",
        },
        {
          "DocEntry": 1169,
          "DocNum": 1169,
          "DocType": "I",
          "DocStatus": "O",
          "DocDate": "20230825",
          "DocDueDate": "20230924",
          "CardCode": "C30000",
          "SlpCode": "2",
          "DocTotal": 168.000000,
          "DiscPrcnt": 0.000000,
          "DiscSum": 0.000000,
          "VatPercent": 0.000000,
          "VatSum": 28.000000,
          "CANCELED": "N",
        },
        {
          "DocEntry": 1174,
          "DocNum": 1174,
          "DocType": "I",
          "DocStatus": "O",
          "DocDate": "20230216",
          "DocDueDate": "20230317",
          "CardCode": "C30000",
          "SlpCode": "2",
          "DocTotal": 11168.200000,
          "DiscPrcnt": 0.000000,
          "DiscSum": 0.000000,
          "VatPercent": 0.000000,
          "VatSum": 1861.360000,
          "CANCELED": "N",
        },
        {
          "DocEntry": 1278,
          "DocNum": 1243,
          "DocType": "I",
          "DocStatus": "O",
          "DocDate": "20250411",
          "DocDueDate": "20250411",
          "CardCode": "C30000",
          "SlpCode": "2",
          "DocTotal": 2400.000000,
          "DiscPrcnt": 0.000000,
          "DiscSum": 0.000000,
          "VatPercent": 0.000000,
          "VatSum": 400.000000,
          "CANCELED": "N",
        },
        {
          "DocEntry": 1280,
          "DocNum": 1244,
          "DocType": "I",
          "DocStatus": "O",
          "DocDate": "20250411",
          "DocDueDate": "20250504",
          "CardCode": "C30000",
          "SlpCode": "2",
          "DocTotal": 3000.000000,
          "DiscPrcnt": 0.000000,
          "DiscSum": 0.000000,
          "VatPercent": 0.000000,
          "VatSum": 500.000000,
          "CANCELED": "N",
        },
      ],
    },
    "timestamp": 1749638873572,
  });
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
                style: utilities.textTheme.titleSmall?.copyWith(
                  color: mediumTextColor,
                ),
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
  double totalPrice(List<OrderLine> orderLines) {
    double total = 0.0;
    for (var line in orderLines) {
      total += line.lineTotal!;
    }
    return total;
  }
}
