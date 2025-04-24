import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

import 'package:revival/features/business_partners/presentation/view/business_partner_view.dart';
import 'package:revival/features/business_partners/presentation/view/business_partner_view.dart';

class BusinessPartner {
  final String code;
  final String name;
  final double balance;
  final String location;
  final String? contactPerson;
  final String? phone;

  BusinessPartner({
    required this.code,
    required this.name,
    required this.balance,
    required this.location,
    this.contactPerson,
    this.phone,
  });

  String get partnerType {
    if (code.toUpperCase().startsWith('C')) {
      return 'Customer';
    } else if (code.toUpperCase().startsWith('V')) {
      return 'Vendor';
    }
    return 'Other';
  }
}

class AllBusinessPartnerWowListPage extends StatefulWidget {
  const AllBusinessPartnerWowListPage({super.key});

  @override
  State<AllBusinessPartnerWowListPage> createState() =>
      _AllBusinessPartnerWowListPageState();
}

class _AllBusinessPartnerWowListPageState
    extends State<AllBusinessPartnerWowListPage> {
  static const Color primaryColor = Color(0xFF003366);
  static const Color accentColor = Color(0xFF004a99);
  static const Color cardBackgroundColor = Colors.white;
  static const Color backgroundColor = Color(0xFFF0F2F5);
  static const Color labelColor = Color(0xFF6c757d);
  static const Color textColor = Color(0xFF212529);
  static const Color searchBarColor = Color(0xFF002244);

  final List<BusinessPartner> _allBusinessPartners = [
    BusinessPartner(
      code: 'C20000',
      name: 'Global Solutions Inc.',
      balance: 1250.75,
      location: '123 Global Ave, Downtown',
      contactPerson: 'Alice Smith',
      phone: '555-1111',
    ),
    BusinessPartner(
      code: 'C30500',
      name: 'Acme Corporation',
      balance: -890.20,
      location: '45 Industrial Way, West Park',
      contactPerson: 'Bob Jones',
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

  List<BusinessPartner> _filteredBusinessPartners = [];
  final TextEditingController _searchController = TextEditingController();
  final NumberFormat _currencyFormatter = NumberFormat.currency(
    locale: 'en_US',
    symbol: 'EGP',
  );
  String? _expandedPartnerCode;

  String _selectedPartnerType = "All";
  final List<String> _partnerTypeOptions = ["All", "Customers", "Vendors"];

  @override
  void initState() {
    super.initState();

    _filterPartners();
    _searchController.addListener(_filterPartners);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterPartners);
    _searchController.dispose();
    super.dispose();
  }

  void _filterPartners() {
    final query = _searchController.text.toLowerCase();
    final typeFilter = _selectedPartnerType;

    setState(() {
      List<BusinessPartner> tempFiltered = _allBusinessPartners;

      if (typeFilter == "Customers") {
        tempFiltered =
            tempFiltered.where((p) => p.partnerType == 'Customer').toList();
      } else if (typeFilter == "Vendors") {
        tempFiltered =
            tempFiltered.where((p) => p.partnerType == 'Vendor').toList();
      }

      if (query.isNotEmpty) {
        tempFiltered =
            tempFiltered.where((partner) {
              final nameLower = partner.name.toLowerCase();
              final codeLower = partner.code.toLowerCase();
              return nameLower.contains(query) || codeLower.contains(query);
            }).toList();
      }

      _filteredBusinessPartners = tempFiltered;

      _expandedPartnerCode = null;
    });
  }

  Color _getBalanceColor(double balance) {
    if (balance < 0) return Colors.red.shade700;
    if (balance == 0) return labelColor;
    return Colors.green.shade700;
  }

  @override
  Widget build(BuildContext context) {
    final bool isSearching = _searchController.text.isNotEmpty;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(_selectedPartnerType)
            .animate()
            .fadeIn(duration: 400.ms)
            .slideY(begin: -0.2, duration: 300.ms, curve: Curves.easeOut),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 2.0,

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(120.0),
          child: Container(
            color: primaryColor,
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                  cursorColor: Colors.white.withOpacity(0.7),
                  decoration: InputDecoration(
                    hintText: 'Search Name or Code...',
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white.withOpacity(0.8),
                      size: 20,
                    ),
                    filled: true,
                    fillColor: searchBarColor.withOpacity(0.8),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 15,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon:
                        isSearching
                            ? IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: Icon(
                                Icons.clear,
                                color: Colors.white.withOpacity(0.8),
                                size: 20,
                              ),
                              onPressed: () => _searchController.clear(),
                            )
                            : null,
                  ),
                ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.2),

                const SizedBox(height: 8),

                SizedBox(
                  height: 45,
                  child: DropdownButtonFormField<String>(
                    value: _selectedPartnerType,
                    isExpanded: true,
                    items:
                        _partnerTypeOptions.map((String type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Text(
                              type,
                              style: const TextStyle(fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue == null || newValue == _selectedPartnerType)
                        return;
                      setState(() {
                        _selectedPartnerType = newValue;
                        _filterPartners();
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: cardBackgroundColor,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: accentColor,
                          width: 1.5,
                        ),
                      ),
                    ),
                    style: TextStyle(color: textColor, fontSize: 14),
                    icon: Icon(
                      Icons.filter_alt_outlined,
                      color: primaryColor,
                      size: 20,
                    ),
                    dropdownColor: cardBackgroundColor,
                  ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.3),
                ),
              ],
            ),
          ),
        ),
      ),
      body: _buildPartnerList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewBusinessPartnerPage()),
          );
        },
        backgroundColor: accentColor,
        foregroundColor: Colors.white,
        tooltip: 'Add New Partner',
        child: const Icon(Icons.add),
      ).animate().scale(
        delay: 500.ms,
        duration: 400.ms,
        curve: Curves.elasticOut,
      ),
    );
  }

  Widget _buildPartnerList() {
    if (_filteredBusinessPartners.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_off_rounded, size: 70, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                'No Business Partners Found',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),

              if (_selectedPartnerType != "All" ||
                  _searchController.text.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Try adjusting your search or type filter.',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.grey[500]),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ).animate().fadeIn(duration: 300.ms);
    }

    return ListView.builder(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 8.0,
        right: 8.0,
        bottom: 80.0,
      ),
      itemCount: _filteredBusinessPartners.length,
      itemBuilder: (context, index) {
        final partner = _filteredBusinessPartners[index];
        final bool isExpanded = _expandedPartnerCode == partner.code;

        return BusinessPartnerExpandableCard(
              partner: partner,
              currencyFormatter: _currencyFormatter,
              getBalanceColor: _getBalanceColor,
              isExpanded: isExpanded,
              onTap: () {
                setState(() {
                  if (_expandedPartnerCode == partner.code) {
                    _expandedPartnerCode = null;
                  } else {
                    _expandedPartnerCode = partner.code;
                  }
                });
              },
              primaryColor: primaryColor,
              accentColor: accentColor,
              cardBackgroundColor: cardBackgroundColor,
              labelColor: labelColor,
              textColor: textColor,
            )
            .animate(delay: (100 * (index % 10)).ms)
            .fadeIn(duration: 500.ms)
            .slideY(begin: 0.1, duration: 400.ms, curve: Curves.easeOutCubic);
      },
    );
  }
}

class BusinessPartnerExpandableCard extends StatelessWidget {
  final BusinessPartner partner;
  final NumberFormat currencyFormatter;
  final Color Function(double) getBalanceColor;
  final bool isExpanded;
  final VoidCallback onTap;
  final Color primaryColor;
  final Color accentColor;
  final Color cardBackgroundColor;
  final Color labelColor;
  final Color textColor;

  const BusinessPartnerExpandableCard({
    super.key,
    required this.partner,
    required this.currencyFormatter,
    required this.getBalanceColor,
    required this.isExpanded,
    required this.onTap,
    required this.primaryColor,
    required this.accentColor,
    required this.cardBackgroundColor,
    required this.labelColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final balanceColor = getBalanceColor(partner.balance);
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: isExpanded ? 4.0 : 1.5,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: cardBackgroundColor,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        splashColor: primaryColor.withOpacity(0.1),
        highlightColor: primaryColor.withOpacity(0.05),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: primaryColor.withOpacity(0.1),
                    child: Icon(
                      Icons.business_center_outlined,
                      size: 20,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          partner.name,
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          partner.code,
                          style: textTheme.bodySmall?.copyWith(
                            color: labelColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        currencyFormatter.format(partner.balance),
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: balanceColor,
                        ),
                      ),
                      Text(
                        'Balance',
                        style: textTheme.bodySmall?.copyWith(
                          color: labelColor.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Icon(
                        isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: labelColor,
                        size: 24,
                      ),
                    ],
                  ),
                ],
              ),

              AnimatedSize(
                duration: 300.ms,
                curve: Curves.easeInOutCubic,
                alignment: Alignment.topCenter,
                child: Visibility(
                  visible: isExpanded,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(height: 1, thickness: 0.5),
                        const SizedBox(height: 12),
                        _buildDetailRow(
                          Icons.location_on_outlined,
                          "Location",
                          partner.location,
                          textTheme,
                        ),
                        if (partner.contactPerson != null)
                          _buildDetailRow(
                            Icons.person_outline,
                            "Contact",
                            partner.contactPerson!,
                            textTheme,
                          ),
                        if (partner.phone != null)
                          _buildDetailRow(
                            Icons.phone_outlined,
                            "Phone",
                            partner.phone!,
                            textTheme,
                          ),
                        const SizedBox(height: 16),
                        Center(
                          child: ElevatedButton.icon(
                                icon: const Icon(
                                  Icons.receipt_long_outlined,
                                  size: 18,
                                ),
                                label: const Text('Create Invoice'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: accentColor,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Create Invoice for ${partner.name} (${partner.code})',
                                      ),
                                    ),
                                  );
                                },
                              )
                              .animate()
                              .fadeIn(delay: 150.ms)
                              .scaleXY(begin: 0.8, curve: Curves.elasticOut),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    IconData icon,
    String label,
    String value,
    TextTheme textTheme,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: primaryColor.withOpacity(0.8)),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: textTheme.bodySmall?.copyWith(
              color: labelColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: textTheme.bodyMedium?.copyWith(color: textColor),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color primaryColor = Color(0xFF003366);
  static const Color accentColor = Color(0xFF004a99);
  static const Color backgroundColor = Color(0xFFF0F2F5);
  static const Color cardBackgroundColor = Colors.white;
  static const Color textColor = Color(0xFF212529);
  static const Color labelColor = Color(0xFF6c757d);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: accentColor,
        background: backgroundColor,
        onBackground: textColor,
        surface: cardBackgroundColor,
        onSurface: textColor,
        error: Colors.red.shade700,
        brightness: Brightness.light,
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 2.0,
        titleTextStyle: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      cardTheme: CardTheme(
        elevation: 1.5,
        color: cardBackgroundColor,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: accentColor,
        foregroundColor: Colors.white,
      ),
      textTheme: const TextTheme(
        labelSmall: TextStyle(color: labelColor),
      ).apply(bodyColor: textColor, displayColor: textColor),
    );

    return MaterialApp(
      title: 'SAP B1 Van Sales Customers',
      theme: theme,
      home: const AllBusinessPartnerWowListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
