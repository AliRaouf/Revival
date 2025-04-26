import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:revival/features/business_partners/domain/entities/business_partner.dart';

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
      'title'.tr(): 'Stock'.tr(),
      'icon'.tr(): Icons.inventory_2_outlined,
      'path'.tr(): '/stock',
    },
    {
      'title'.tr(): 'Collect'.tr(),
      'icon'.tr(): Icons.payments_outlined,
      'path'.tr(): '/order',
    },
    {
      'title'.tr(): 'Reports'.tr(),
      'icon'.tr(): Icons.bar_chart_rounded,
      'path'.tr(): '/order',
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
    BusinessPartner(
      code: 'C20000'.tr(),
      name: 'Global Solutions Inc.'.tr(),
      balance: 1250.75,
      location: '123 Global Ave, Downtown'.tr(),
      contactPerson: 'Alice Smith'.tr(),
      phone: '555-1111'.tr(),
    ),
    BusinessPartner(
      code: 'C30500'.tr(),
      name: 'Acme Corporation'.tr(),
      balance: -890.20,
      location: '45 Industrial Way, West Park'.tr(),
      contactPerson: 'Bob Jones'.tr(),
      phone: '555-2222',
    ),
    BusinessPartner(
      code: 'V10000',
      name: 'Tech Innovators Ltd.',
      balance: 345.99,
      location: '789 Tech Rd, Silicon Alley',
      contactPerson: 'Charlie Kim',
    ),
    BusinessPartner(
      code: 'C20010',
      name: 'Sunrise Ventures',
      balance: 2100.50,
      location: '1 Sunrise Blvd, Eastside',
      phone: '555-4444',
    ),
    BusinessPartner(
      code: 'V10050',
      name: 'Pinnacle Group',
      balance: 567.80,
      location: '2 Pinnacle Plz, North Hub',
      contactPerson: 'Diana Ross',
      phone: '555-5555',
    ),
    BusinessPartner(
      code: 'C30000',
      name: 'Alpha Industries',
      balance: 0.00,
      location: '3 Alpha Cres, Airport Zone',
    ),
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
}
