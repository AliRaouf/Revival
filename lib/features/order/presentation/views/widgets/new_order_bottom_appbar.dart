import 'package:flutter/material.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/core/utils/toast_utils.dart';
import 'package:revival/shared/utils.dart';

class NewOrderBottomAppbar extends StatelessWidget {
  static const String estimatedTotal = '0.00 GBP';
  final void Function() saveDraft;
  final void Function() submitOrder;
  const NewOrderBottomAppbar(
    BuildContext context, {
    super.key,
    required this.saveDraft,
    required this.submitOrder,
  });

  @override
  Widget build(BuildContext context) {
    final utilities = Utilities(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: utilities.theme.cardColor,
        boxShadow: [
          BoxShadow(
            color: utilities.theme.shadowColor.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 6,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Estimated net total",
                style: utilities.textTheme.bodyLarge?.copyWith(
                  color: mediumTextColor,
                ),
              ),
              Row(
                children: [
                  Text(
                    estimatedTotal,
                    style: utilities.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: utilities.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      ToastUtils.showInfoToast(
                        context,
                        'Recalculate total not implemented.',
                      );
                    },
                    child: Icon(
                      Icons.refresh,
                      color: utilities.colorScheme.primary,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: saveDraft,

                  child: Text("Save Draft"),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: submitOrder,

                  child: Text("Submit"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
