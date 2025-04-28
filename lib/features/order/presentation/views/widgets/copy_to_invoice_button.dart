import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:revival/features/order/presentation/views/single_order.dart';

class CopyToInvoiceCollectButton extends StatelessWidget {
  final String type;
  const CopyToInvoiceCollectButton({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: wowPrimaryMagenta,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
          elevation: 3.0,
          shadowColor: wowPrimaryMagenta.withOpacity(0.4),
        ),
        onPressed: () {
          context.push('/invoice');
          print('Copy to Invoice button tapped');
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
