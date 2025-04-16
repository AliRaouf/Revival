import 'package:flutter/material.dart';

class OrderSummaryWidget extends StatelessWidget {
  final String orderCode;
  final String customerName;
  final String quote;
  final String order;
  final String invoice;

  const OrderSummaryWidget({
    super.key,
    required this.orderCode,
    required this.customerName,
    required this.quote,
    required this.order,
    required this.invoice,
  });

  @override
  Widget build(BuildContext context) {
    const mainColor = Color(0xFF607D8B); // blue-gray

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top row with badge and customer name
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: mainColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '#$orderCode',
                  style: TextStyle(
                    color: mainColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              Row(
                children: const [
                  Icon(Icons.table_chart, size: 16, color: Colors.black54),
                  SizedBox(width: 4),
                  Text('2Demo', style: TextStyle(color: Colors.black87)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            orderCode,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),

          /// Bottom row with Quote / Order / Invoice
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildAmountColumn('Quote', quote, mainColor),
              _buildAmountColumn('Order', order, mainColor),
              _buildAmountColumn('Invoice', invoice, mainColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAmountColumn(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
