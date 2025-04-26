import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:revival/features/order/presentation/views/widgets/copy_to_invoice_button.dart';

const Color primaryMagenta = Color(0xFF173F5D);
const Color secondaryMagenta = Color(0xFF173F5D);
const Color backgroundColor = Color(0xFFFFFFFF);
const Color lightBackground = Color(0xFFF9FAFB);
const Color darkTextColor = Color(0xFF1A202C);
const Color mediumTextColor = Color(0xFF4A5568);
const Color lightTextColor = Color(0xFF718096);
const Color subtleBorderColor = Color(0xFFE2E8F0);
const Color shadowColor = Color(0xFFE2E8F0);

class SingleInvoiceScreen extends StatelessWidget {
  final String invoiceId;

  const SingleInvoiceScreen({super.key, required this.invoiceId});

  @override
  Widget build(BuildContext context) {
    final String customerName = '2Demo (VAT Exempt)';
    final orderData = _getPlaceholderInvoiceData(invoiceId);
    final DateFormat dateFormat = DateFormat('EEEE, MMMM d, yyyy');

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: singleInvoiceAppBar(context, invoiceId, customerName),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  infoRow(
                    label: 'Customer',
                    value: orderData['customerType'] as String,
                    valueFontSize: 16,
                    isValueBold: true,
                  ),
                  const SizedBox(height: 18),
                  infoRow(
                    label: 'Document Date',
                    value: dateFormat.format(
                      orderData['documentDate'] as DateTime,
                    ),
                  ),
                  const SizedBox(height: 18),
                  infoRow(
                    label: 'Delivery Date',
                    value: dateFormat.format(
                      orderData['deliveryDate'] as DateTime,
                    ),
                  ),
                  const SizedBox(height: 18),
                  infoRow(
                    label: 'Reference Number',
                    value: orderData['referenceNumber'] as String? ?? '-',
                  ),
                  const SizedBox(height: 18),
                  infoRow(
                    label: 'Title',
                    value: orderData['title'] as String? ?? '-',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            sectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  infoRow(
                    label: 'Sales Person',
                    value: orderData['salesPerson'] as String,
                    valueFontSize: 16,
                    isValueBold: true,
                  ),
                  const SizedBox(height: 18),
                  infoRow(
                    label: 'Contact Person',
                    value: orderData['contactPerson'] as String? ?? '-',
                  ),
                  const SizedBox(height: 20),

                  contactActions(),
                ],
              ),
            ),
            const SizedBox(height: 24),

            invoiceButton(
              label: 'Custom Fields',
              onTap: () {
                print('Custom Fields button tapped');
              },
            ),
            const SizedBox(height: 24),

            Text(
              'Items',
              style: TextStyle(
                color: mediumTextColor,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 12),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: (orderData['items'] as List).length,
              itemBuilder: (context, index) {
                final item = (orderData['items'] as List)[index];
                return itemRow(
                  code: item['code'] as String,
                  name: item['name'] as String,
                  price: item['price'] as double,
                  discount: item['discount'] as double,
                  currency: item['currency'] as String,
                  quantity: item['quantity'] as double,
                );
              },
              separatorBuilder:
                  (context, index) => const Divider(
                    height: 24,
                    thickness: 1,
                    color: subtleBorderColor,
                  ),
            ),
            const SizedBox(height: 24),

            sectionCard(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                children: [
                  totalRow(
                    label: 'Discount',
                    value:
                        '${(orderData['discountPercent'] as double).toStringAsFixed(2)}% (${(orderData['discountValue'] as double).toStringAsFixed(2)} ${orderData['currency']})',
                  ),
                  const SizedBox(height: 12),
                  totalRow(
                    label: 'VAT',
                    value:
                        '${(orderData['vatValue'] as double).toStringAsFixed(2)} ${orderData['currency']}',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      color: subtleBorderColor.withOpacity(0.6),
                    ),
                  ),
                  totalRow(
                    label: 'Total',
                    value:
                        '${(orderData['totalValue'] as double).toStringAsFixed(2)} ${orderData['currency']}',
                    isValueBold: true,
                    valueFontSize: 20,
                    valueColor: primaryMagenta,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            CopyToInvoiceCollectButton(type: "Collect"),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _getPlaceholderInvoiceData(String orderId) {
    return {
      'customerType': 'VAT Exempted Customer',
      'documentDate': DateTime(2023, 10, 12),
      'deliveryDate': DateTime(2023, 10, 12),
      'referenceNumber': 'REF-${orderId.split('._').last}',
      'title': 'Demo Order Title',
      'salesPerson': 'Admin User',
      'contactPerson': 'Contact Person Name',
      'contactPhone': '',
      'contactEmail': '',
      'items': [
        {
          'code': 'B001',
          'name': 'Dune',
          'price': 10.00,
          'discount': 0.00,
          'currency': 'EUR',
          'quantity': 1.00,
        },
        {
          'code': 'A015',
          'name': 'Spice Blend',
          'price': 25.50,
          'discount': 2.50,
          'currency': 'EUR',
          'quantity': 2.00,
        },
      ],
      'discountValue': 2.50 * 2,
      'discountPercent': 10.00,
      'vatValue': ((10.00 * 1.00) + (23.00 * 2.00)) * 0.15,
      'totalValue':
          (10.00 * 1.00) +
          (23.00 * 2.00) +
          (((10.00 * 1.00) + (23.00 * 2.00)) * 0.15),
      'currency': 'EUR',
    };
  }

  PreferredSizeWidget singleInvoiceAppBar(
    BuildContext context,
    String orderId,
    String customerName,
  ) {
    return AppBar(
      backgroundColor: primaryMagenta,
      elevation: 2.0,
      shadowColor: primaryMagenta.withOpacity(0.3),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
          size: 22,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Invoice $orderId',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            customerName,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      centerTitle: false,
      titleSpacing: -5,
      actions: [
        IconButton(
          icon: const Icon(Icons.email_outlined, color: Colors.white, size: 24),
          tooltip: 'Email Order',
          onPressed: () {
            print('Email button tapped');
          },
        ),
        IconButton(
          icon: const Icon(Icons.print_outlined, color: Colors.white, size: 24),
          tooltip: 'Print Order',
          onPressed: () {
            print('Print button tapped');
          },
        ),
      ],
    );
  }

  Widget sectionCard({required Widget child, EdgeInsets? padding}) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: lightBackground,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: subtleBorderColor, width: 0.8),
      ),
      child: child,
    );
  }

  Widget infoRow({
    required String label,
    required String value,
    bool isValueBold = false,
    double valueFontSize = 15.0,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              color: lightTextColor,
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value.isEmpty ? '-' : value,
            style: TextStyle(
              color: darkTextColor,
              fontSize: valueFontSize,
              fontWeight: isValueBold ? FontWeight.w600 : FontWeight.normal,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget contactActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Actions',
          style: TextStyle(
            color: lightTextColor,
            fontSize: 11,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            contactIconButton(
              icon: Icons.phone_outlined,
              tooltip: 'Call Contact',
              onTap: () {
                print('Phone button tapped');
              },
            ),
            const SizedBox(width: 16),
            contactIconButton(
              icon: Icons.email_outlined,
              tooltip: 'Email Contact',
              onTap: () {
                print('Contact email button tapped');
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget contactIconButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryMagenta,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(10),
        minimumSize: const Size(40, 40),
        elevation: 2.0,
        shadowColor: primaryMagenta.withOpacity(0.4),
      ),
      child: Tooltip(message: tooltip, child: Icon(icon, size: 20)),
    );
  }

  Widget invoiceButton({required String label, required VoidCallback onTap}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryMagenta,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
          elevation: 3.0,
          shadowColor: primaryMagenta.withOpacity(0.4),
        ),
        onPressed: onTap,
        child: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget itemRow({
    required String code,
    required String name,
    required double price,
    required double discount,
    required String currency,
    required double quantity,
  }) {
    final double itemTotal = (price * quantity) - (discount * quantity);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3.0),
            child: Icon(
              Icons.inventory_2_outlined,
              color: backgroundColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: darkTextColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Code: $code',
                  style: const TextStyle(color: lightTextColor, fontSize: 12),
                ),
                const SizedBox(height: 5),
                Text(
                  'Price: ${price.toStringAsFixed(2)} ${discount > 0 ? " / Disc: ${discount.toStringAsFixed(2)} " : ""} $currency',
                  style: const TextStyle(color: mediumTextColor, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'x ${quantity.toStringAsFixed(quantity.truncateToDouble() == quantity ? 0 : 2)}',
                style: const TextStyle(
                  color: mediumTextColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '${itemTotal.toStringAsFixed(2)} $currency',
                style: const TextStyle(
                  color: darkTextColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget totalRow({
    required String label,
    required String value,
    bool isValueBold = false,
    double valueFontSize = 15.0,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: mediumTextColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? darkTextColor,
            fontSize: valueFontSize,
            fontWeight: isValueBold ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
