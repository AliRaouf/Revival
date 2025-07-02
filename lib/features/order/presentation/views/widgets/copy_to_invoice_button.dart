import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/features/order/data/models/copy_to_invoice/copy_to_invoice.dart';
import 'package:revival/features/order/presentation/cubit/copy_order_invoice/copy_order_invoice_cubit.dart';

class CopyToInvoiceCollectButton extends StatelessWidget {
  final String type;
  final CopyToInvoice copyToInvoiceData;
  const CopyToInvoiceCollectButton({
    super.key,
    required this.type,
    required this.copyToInvoiceData,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
          elevation: 3.0,
          shadowColor: primaryColor.withOpacity(0.4),
        ),
        onPressed: () {
          context.read<CopyOrderInvoiceCubit>().copyOrderToInvoice(
            copyToInvoiceData.documentLines?[0].baseEntry.toString() ?? "3",
            copyToInvoiceData,
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Copy to $type',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward, size: 18),
          ],
        ),
      ),
    );
  }
}
