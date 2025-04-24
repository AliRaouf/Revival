import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const Color wowPrimaryMagenta = Color(0xFF173F5D);
const Color wowSecondaryMagenta = Color(0xFF173F5D);
const Color wowBackgroundColor = Color(0xFFFFFFFF);
const Color wowLightBackground = Color(0xFFF9FAFB);
const Color wowDarkTextColor = Color(0xFF1A202C);
const Color wowMediumTextColor = Color(0xFF4A5568);
const Color wowLightTextColor = Color(0xFF718096);
const Color wowSubtleBorderColor = Color(0xFFE2E8F0);
const Color wowShadowColor = Color(0xFFE2E8F0);

class SingleOrderScreen extends StatelessWidget {
  final String orderId;

  const SingleOrderScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    print("Received Order ID: $orderId");

    final String customerName = "2Demo (VAT Exempt)";
    final orderData = _getPlaceholderOrderData(orderId);
    final DateFormat dateFormat = DateFormat('EEEE, MMMM d, yyyy');

    return Scaffold(
      backgroundColor: wowBackgroundColor,
      appBar: _buildWowAppBar(context, orderId, customerName),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildWowInfoRow(
                    label: 'Customer',
                    value: orderData['customerType'] as String,
                    valueFontSize: 16,
                    isValueBold: true,
                  ),
                  const SizedBox(height: 18),
                  _buildWowInfoRow(
                    label: 'Document date',
                    value: dateFormat.format(
                      orderData['documentDate'] as DateTime,
                    ),
                  ),
                  const SizedBox(height: 18),
                  _buildWowInfoRow(
                    label: 'Delivery date',
                    value: dateFormat.format(
                      orderData['deliveryDate'] as DateTime,
                    ),
                  ),
                  const SizedBox(height: 18),
                  _buildWowInfoRow(
                    label: 'Reference number',
                    value: orderData['referenceNumber'] as String? ?? '-',
                  ),
                  const SizedBox(height: 18),
                  _buildWowInfoRow(
                    label: 'Title',
                    value: orderData['title'] as String? ?? '-',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            _buildSectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildWowInfoRow(
                    label: 'Sales person',
                    value: orderData['salesPerson'] as String,
                    valueFontSize: 16,
                    isValueBold: true,
                  ),
                  const SizedBox(height: 18),
                  _buildWowInfoRow(
                    label: 'Contact person',
                    value: orderData['contactPerson'] as String? ?? '-',
                  ),
                  const SizedBox(height: 20),

                  _buildWowContactActions(),
                ],
              ),
            ),
            const SizedBox(height: 24),

            _buildWowTextButton(
              label: 'CUSTOM FIELDS',
              onTap: () {
                print('Custom Fields button tapped');
              },
            ),
            const SizedBox(height: 24),

            const Text(
              'ITEMS',
              style: TextStyle(
                color: wowMediumTextColor,
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
                return _buildWowItemRow(
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
                    color: wowSubtleBorderColor,
                  ),
            ),
            const SizedBox(height: 24),

            _buildSectionCard(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                children: [
                  _buildWowTotalRow(
                    label: 'Discount:',
                    value:
                        "${(orderData['discountPercent'] as double).toStringAsFixed(2)}% (${(orderData['discountValue'] as double).toStringAsFixed(2)} ${orderData['currency']})",
                  ),
                  const SizedBox(height: 12),
                  _buildWowTotalRow(
                    label: 'VAT:',
                    value:
                        "${(orderData['vatValue'] as double).toStringAsFixed(2)} ${orderData['currency']}",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      color: wowSubtleBorderColor.withOpacity(0.6),
                    ),
                  ),
                  _buildWowTotalRow(
                    label: 'Total:',
                    value:
                        "${(orderData['totalValue'] as double).toStringAsFixed(2)} ${orderData['currency']}",
                    isValueBold: true,
                    valueFontSize: 20,
                    valueColor: wowPrimaryMagenta,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            _buildCopyToInvoiceButton(),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _getPlaceholderOrderData(String orderId) {
    return {
      'customerType': 'VAT Exempted Customer',
      'documentDate': DateTime(2023, 10, 12),
      'deliveryDate': DateTime(2023, 10, 12),
      'referenceNumber': 'REF-${orderId.split('_').last}',
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

  PreferredSizeWidget _buildWowAppBar(
    BuildContext context,
    String orderId,
    String customerName,
  ) {
    return AppBar(
      backgroundColor: wowPrimaryMagenta,
      elevation: 2.0,
      shadowColor: wowPrimaryMagenta.withOpacity(0.3),
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
            'Order $orderId',
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

  Widget _buildSectionCard({required Widget child, EdgeInsets? padding}) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: wowLightBackground,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: wowSubtleBorderColor, width: 0.8),
      ),
      child: child,
    );
  }

  Widget _buildWowInfoRow({
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
              color: wowLightTextColor,
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value.isEmpty ? '-' : value,
            style: TextStyle(
              color: wowDarkTextColor,
              fontSize: valueFontSize,
              fontWeight: isValueBold ? FontWeight.w600 : FontWeight.normal,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWowContactActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'CONTACT ACTIONS',
          style: TextStyle(
            color: wowLightTextColor,
            fontSize: 11,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildWowIconButton(
              icon: Icons.phone_outlined,
              tooltip: 'Call Contact',
              onTap: () {
                print('Phone button tapped');
              },
            ),
            const SizedBox(width: 16),
            _buildWowIconButton(
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

  Widget _buildWowIconButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: wowPrimaryMagenta,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(10),
        minimumSize: const Size(40, 40),
        elevation: 2.0,
        shadowColor: wowPrimaryMagenta.withOpacity(0.4),
      ),
      child: Tooltip(message: tooltip, child: Icon(icon, size: 20)),
    );
  }

  Widget _buildWowTextButton({
    required String label,
    required VoidCallback onTap,
  }) {
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

  Widget _buildWowItemRow({
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
              color: wowBackgroundColor,
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
                    color: wowDarkTextColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Code: $code',
                  style: const TextStyle(
                    color: wowLightTextColor,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Price: ${price.toStringAsFixed(2)} ${discount > 0 ? " / Disc: ${discount.toStringAsFixed(2)} " : ""} $currency',
                  style: const TextStyle(
                    color: wowMediumTextColor,
                    fontSize: 12,
                  ),
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
                  color: wowMediumTextColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '${itemTotal.toStringAsFixed(2)} $currency',
                style: const TextStyle(
                  color: wowDarkTextColor,
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

  Widget _buildWowTotalRow({
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
            color: wowMediumTextColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? wowDarkTextColor,
            fontSize: valueFontSize,
            fontWeight: isValueBold ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildCopyToInvoiceButton() {
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
          print('Copy to Invoice button tapped');
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'COPY TO INVOICE',
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
