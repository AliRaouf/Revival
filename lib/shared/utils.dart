import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:revival/features/business_partners/data/models/business_partner/business_partner.dart';
import 'package:revival/features/sales_analysis/domain/entity/sales_entry.dart';

class Utilities {
  final BuildContext context;

  Utilities(this.context);

  double vSpace(double factor) => 16 * factor;

  late final theme = Theme.of(context);
  late final textTheme = theme.textTheme;
  late final colorScheme = theme.colorScheme;
  late final cardTheme = theme.cardTheme;
  late final iconSize = isTablet ? 48.0 : 36.0;
  late final splashColor = theme.splashColor;
  late final highlightColor = theme.highlightColor;
  late final mq = MediaQuery.of(context);
  late final screenSize = mq.size;
  late final isTablet = screenSize.width > 600;
  late final crossAxisCount = isTablet ? 3 : 2;

  late final aspectRatio = isTablet ? 1.1 : 1.0;

  final List<SalesEntry> fakeSalesData = [
    SalesEntry(
      number: 1,
      date: DateTime(2025, 4, 28), // Using current year based on context
      paymentMethod: 'Visa Card',
      items: ['Laptop Charger', 'Mouse Pad XL'],
      discount: 0.0,
      total: 65.00,
    ),
    SalesEntry(
      number: 2,
      date: DateTime(2025, 4, 28),
      paymentMethod: 'Cash',
      items: ['USB-C Cable', 'Wall Adapter'],
      discount: 5.0,
      total: 33.25,
    ),
    SalesEntry(
      number: 3,
      date: DateTime(2025, 4, 27),
      paymentMethod: 'Mobile Wallet',
      items: ['Headphones - Wireless', 'Case'],
      discount: 10.0,
      total: 135.00,
    ),
    SalesEntry(
      number: 4,
      date: DateTime(2025, 4, 26),
      paymentMethod: 'Mastercard',
      items: ['Mechanical Keyboard', 'Wrist Rest'],
      discount: 15.0,
      total: 148.75,
    ),
    SalesEntry(
      number: 5,
      date: DateTime(2025, 4, 25),
      paymentMethod: 'Bank Transfer',
      items: ['Projector', 'Screen (Portable)'],
      discount: 5.0,
      total: 475.00,
    ),
    SalesEntry(
      number: 6,
      date: DateTime(2025, 4, 25),
      paymentMethod: 'PayPal',
      items: ['Software Subscription - 1 Year'],
      discount: .0,
      total: 96.00,
    ),
    SalesEntry(
      number: 7,
      date: DateTime(2025, 4, 24),
      paymentMethod: 'Cash',
      items: ['Monitor Arm', 'Cable Ties (Pack)'],
      discount: 0.0,
      total: 88.50,
    ),
    SalesEntry(
      number: 8,
      date: DateTime(2025, 4, 23),
      paymentMethod: 'Visa Card',
      items: ['External Hard Drive 2TB'],
      discount: 0.0,
      total: 110.00,
    ),
    SalesEntry(
      number: 9,
      date: DateTime(2025, 4, 22),
      paymentMethod: 'Mobile Wallet',
      items: ['Smart Watch', 'Extra Strap'],
      discount: 10.0,
      total: 243.00,
    ),
    SalesEntry(
      number: 10,
      date: DateTime(2025, 4, 21),
      paymentMethod: 'Cash',
      items: ['Ring Light', 'Tripod'],
      discount: 5.0,
      total: 52.25,
    ),
    SalesEntry(
      number: 11,
      date: DateTime(2025, 4, 20),
      paymentMethod: 'Mastercard',
      items: ['Graphic Tablet'],
      discount: 0.0,
      total: 99.99,
    ),
    SalesEntry(
      number: 12,
      date: DateTime(25, 4, 19),
      paymentMethod: 'Bank Transfer',
      items: ['Router AC', 'Ethernet Cable 10m'],
      discount: 10.0,
      total: 117.00,
    ),
  ];
  final menuItems = [
    {
      'title': 'Business Partner'.tr(),
      'icon': Icons.people_alt_outlined,
      'path': '/business_partners',
    },
    {
      'title': 'Orders'.tr(),
      'icon': Icons.receipt_long_outlined,
      'path': '/order',
    },
    {
      'title': 'AR Invoice'.tr(),
      'icon': Icons.request_quote_outlined,
      'path': '/invoice',
    },
    {
      'title': 'Stock'.tr(),
      'icon': Icons.inventory_2_outlined,
      'path': '/stock',
    },
    {
      'title': 'Sales Analysis'.tr(),
      'icon': Icons.bar_chart_rounded,
      'path': '/sales_analysis',
    },
    {
      'title': 'Inventory Analysis'.tr(),
      'icon': Icons.inventory_rounded,
      'path': '/order',
    },
  ];
  final List<Color> menuItemColors = [
    const Color(0xFFE0F2F1),
    const Color(0xFFE1F5FE),
    const Color(0xFFE8F5E9),
    const Color(0xFFF3E5F5),
    const Color(0xFFFFF3E0),
    const Color(0xFFE8EAF6),
  ];
  final List<BusinessPartner> allBusinessPartners = [
  ];
  Color getBalanceColor(BuildContext context, double balance) {
    if (balance < 0) return Colors.red.shade700; // Use a standard red
    if (balance == 0) {
      return textTheme.bodySmall?.color ?? Colors.grey; // Use a subtle grey
    }
    return Colors.green.shade700; // Use a standard green
  }

  final List<String> typeOptions = ['Customer', 'Supplier', 'Lead'];
  final List<String> currencyOptions = [
    'USD',
    'EUR',
    'GBP',
    'JPY',
    'CAD',
    'EGP',
  ];
  final List<String> paymentTermsOptions = [
    'Net 30',
    'Net 60',
    'Due on Receipt',
    'Custom',
  ];
  final List<String> priceListOptions = [
    'Retail Price List',
    'Wholesale Price List',
    'Distributor Price List',
  ];
  final List<String> groupNoOptions = [
    'G001',
    'G002',
    'CUST-Domestic',
    'CUST-Intl',
  ];
  final List<String> addressIdOptions = [
    'BILL_TO_MAIN',
    'SHIP_TO_WAREHOUSE',
    'HQ',
    'Branch-1',
  ];
  void showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Select Language'),
          children:
              context.supportedLocales.map((locale) {
                final isSelected = context.locale == locale;
                return ListTile(
                  title: Text(
                    locale.languageCode == 'en' ? 'English' : 'العربية',
                  ),
                  trailing:
                      isSelected
                          ? const Icon(Icons.check, color: Colors.green)
                          : null,
                  onTap: () {
                    context.setLocale(locale);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
        );
      },
    );
  }
}
